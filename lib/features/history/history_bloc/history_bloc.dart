import 'package:dio/dio.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/history/history_models/booking_model.dart';
import 'package:dockflow_app/features/history/history_models/booking_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final apiClient = ApiClient();

  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistoryEvent>((event, emit) async {
      emit(HistoryLoading());

      try {
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

        final response = await apiClient.dio.get(
          '/booking-history',
          queryParameters: queryParams,
        );

        if (response.data['status'] == true) {
          final data = response.data['data'];

          final summary = BookingSummary.fromJson(data['summary']);

          final bookings = (data['bookings'] as List)
              .map((booking) => BookingModel.fromJson(booking))
              .toList();

          emit(HistoryLoaded(
            summary: summary,
            bookings: bookings,
            selectedStatus: event.status,
            searchQuery: event.search,
            selectedDate: event.date,
          ));
        } else {
          emit(HistoryError(message: "Gagal memuat data riwayat"));
        }
      } on DioException catch (e) {
        String errorMsg = "Terjadi kesalahan koneksi";

        if (e.response != null) {
          errorMsg = e.response?.data['message'] ?? "Gagal memuat data";
        }

        emit(HistoryError(message: errorMsg));
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
