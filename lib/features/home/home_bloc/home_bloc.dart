import 'package:dio/dio.dart';
import 'package:dockflow_app/core/models/user.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/home/home_models/attendance.dart';
import 'package:dockflow_app/features/home/home_models/stock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final apiClient = ApiClient();
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      emit(HomeLoading());

      try {
        final results = await Future.wait([
          apiClient.dio.get('/profile'),
          apiClient.dio.get('/information-products'),
          apiClient.dio.get('/get-statistik'),
        ]);

        final ressProfile = results[0];
        final ressStock = results[1];
        final ressAttendance = results[2];

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
        String errorMsg = "Terjadi kesalahan koneksi";

        if (e.response != null) {
          errorMsg = e.response?.data['message'] ?? "Email atau Password salah";
        }

        emit(HomeError(message: errorMsg));
      }
    });
  }
}
