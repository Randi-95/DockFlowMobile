import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/history/history_models/booking_model.dart';
import 'package:dockflow_app/features/history/history_models/booking_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final apiClient = ApiClient();

  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistoryEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> queryParams = {};

      if (event.status != null && event.status!.isNotEmpty) {
        queryParams['status'] = event.status;
      }

      if (event.search != null && event.search!.isNotEmpty) {
        queryParams['search'] = event.search;
      }

      if (event.date != null && event.date!.isNotEmpty) {
        queryParams['date'] = event.date;
      }

      // 1. Buat key cache unik berdasarkan parameter (agar hasil filter juga tersimpan)
      final cacheKey = 'history_data_${queryParams.toString()}';

      // 2. Cek apakah ada data di cache lokal
      final cachedString = prefs.getString(cacheKey);
      bool hasCache = false;

      if (cachedString != null) {
        try {
          final cachedData = jsonDecode(cachedString);
          final summary = BookingSummary.fromJson(cachedData['summary']);
          final bookings = (cachedData['bookings'] as List)
              .map((booking) => BookingModel.fromJson(booking))
              .toList();

          // 3. Tampilkan data dari cache secara langsung (tanpa loading)
          emit(HistoryLoaded(
            summary: summary,
            bookings: bookings,
            selectedStatus: event.status,
            searchQuery: event.search,
            selectedDate: event.date,
          ));
          hasCache = true;
        } catch (e) {
          // Jika gagal parsing cache, abaikan dan lanjut ambil dari API
        }
      }

      // 4. Emit Loading HANYA jika belum ada data di cache sama sekali (pertama kali buka)
      if (!hasCache) {
        emit(HistoryLoading());
      }

      // 5. Selalu ambil data terbaru dari API di background (Cache-Then-Network)
      try {
        final response = await apiClient.dio.get(
          '/booking-history',
          queryParameters: queryParams,
        );

        if (response.data['status'] == true) {
          final data = response.data['data'];

          // 6. Simpan respons sukses ke cache untuk penggunaan offline berikutnya
          await prefs.setString(cacheKey, jsonEncode(data));

          final summary = BookingSummary.fromJson(data['summary']);

          final bookings = (data['bookings'] as List)
              .map((booking) => BookingModel.fromJson(booking))
              .toList();

          // 7. Update tampilan dengan data terbaru dari API
          emit(HistoryLoaded(
            summary: summary,
            bookings: bookings,
            selectedStatus: event.status,
            searchQuery: event.search,
            selectedDate: event.date,
          ));
        } else {
          // Hanya tampilkan error jika tidak ada cache
          if (!hasCache) {
            emit(HistoryError(message: "Gagal memuat data riwayat"));
          }
        }
      } on DioException catch (e) {
        // Jika sedang offline/koneksi gagal TAPI sudah ada cache, 
        // kita tidak perlu melakukan apa-apa karena state HistoryLoaded (dengan cache) sudah aktif.
        if (!hasCache) {
          String errorMsg = "Terjadi kesalahan koneksi";

          if (e.response != null) {
            errorMsg = e.response?.data['message'] ?? "Gagal memuat data";
          }

          emit(HistoryError(message: errorMsg));
        }
      }
    });

    on<FilterByStatusEvent>((event, emit) {
      add(GetHistoryEvent(status: event.status));
    });

    on<SearchBookingEvent>((event, emit) {
      add(GetHistoryEvent(search: event.search));
    });

    on<FilterByDateEvent>((event, emit) {
      add(GetHistoryEvent(date: event.date));
    });
  }
}
