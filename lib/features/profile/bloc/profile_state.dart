part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileData profile;
  final AttendanceStats stats;

  ProfileLoaded({required this.profile, required this.stats});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
