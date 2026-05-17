import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/profile/profile_service.dart';

// ── Events ────────────────────────────────────────────────────────────────────

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

// ── States ────────────────────────────────────────────────────────────────────

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

// ── Bloc ──────────────────────────────────────────────────────────────────────

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _service = ProfileService();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _service.getProfile();
      final stats = await _service.getAttendanceStats();
      emit(ProfileLoaded(profile: profile, stats: stats));
    } catch (e) {
      emit(ProfileError('Gagal memuat data profil. Silakan coba lagi.'));
    }
  }
}
