part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}


class HomeLoaded extends HomeState {
  final User user;
  final Stock stok;
  final Attendance attendance;
  final int bookingActive;
  HomeLoaded({
    required this.user,
    required this.stok,
    required this.attendance,
    required this.bookingActive
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
