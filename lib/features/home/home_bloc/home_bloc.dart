import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dockflow_app/core/models/user.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/home/home_models/attendance.dart';
import 'package:dockflow_app/features/home/home_models/stock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final apiClient = ApiClient();
  
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = 'home_data_cache';

      final cachedString = prefs.getString(cacheKey);
      bool hasCache = false;

      if (cachedString != null) {
        try {
          final cachedData = jsonDecode(cachedString);
          final profileData = cachedData['profile'];
          final stockData = cachedData['stock'];
          final attendanceData = cachedData['attendance'];

          emit(
            HomeLoaded(
              user: User.fromJson(
                profileData['data'] ?? profileData,
              ),
              stok: Stock.fromJson(stockData),
              attendance: Attendance.fromJson(attendanceData),
              bookingActive: profileData['bookingActive']
            ),
          );
          hasCache = true;
        } catch (e) {
        }
      }

      if (!hasCache) {
        emit(HomeLoading());
      }

      try {
        final results = await Future.wait([
          apiClient.dio.get('/profile'),
          apiClient.dio.get('/information-products'),
          apiClient.dio.get('/get-statistik'),
        ]);

        final ressProfile = results[0];
        final ressStock = results[1];
        final ressAttendance = results[2];

        final cacheDataToSave = {
          'profile': ressProfile.data,
          'stock': ressStock.data,
          'attendance': ressAttendance.data,
        };
        await prefs.setString(cacheKey, jsonEncode(cacheDataToSave));

        emit(
          HomeLoaded(
            user: User.fromJson(
              ressProfile.data['data'] ?? ressProfile.data,
            ),
            stok: Stock.fromJson(ressStock.data),
            attendance: Attendance.fromJson(ressAttendance.data),
            bookingActive: ressProfile.data['bookingActive']
          ),
        );
      } on DioException catch (e) {
        if (!hasCache) {
          String errorMsg = "Terjadi kesalahan koneksi";

          if (e.response != null) {
            errorMsg = e.response?.data['message'] ?? "Email atau Password salah";
          }

          emit(HomeError(message: errorMsg));
        }
      }
    });
  }
}
