import 'package:dio/dio.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/core/storage/authstorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final apiClient = ApiClient();
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await apiClient.dio.post(
          '/login',
          data: {'email': event.email, 'password': event.password},
        );

        if (response.statusCode == 200) {
          final String token = response.data['token'];
          AuthStorage.saveToken(token);
          emit(AuthSucces(succesMessage: "Login Succes"));
        } else {
          emit(AuthError(errorMessage: "Invalid Credentials"));
        }
      } on DioException catch (e) {
        String errorMsg = "Terjadi kesalahan koneksi";

        if (e.response != null) {
          // Mengambil pesan error dari body response server jika ada
          errorMsg = e.response?.data['message'] ?? "Email atau Password salah";
        }

        emit(AuthError(errorMessage: errorMsg));
      }
    });
  }
}
