import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dockflow_app/features/profile/profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

const _kProfileCacheKey = 'profile_data_cache';
const _kStatsCacheKey = 'profile_stats_cache';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _service = ProfileService();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedProfile = prefs.getString(_kProfileCacheKey);
    final cachedStats = prefs.getString(_kStatsCacheKey);
    bool hasCache = false;

    if (cachedProfile != null && cachedStats != null) {
      try {
        final profile = ProfileData.fromCacheJson(jsonDecode(cachedProfile));
        final stats = AttendanceStats.fromJson(jsonDecode(cachedStats));

        emit(ProfileLoaded(profile: profile, stats: stats));
        hasCache = true;
      } catch (e) {
        debugPrint('[ProfileBloc] Cache parse error: $e');
      }
    }

    if (!hasCache) {
      emit(ProfileLoading());
    }

    try {
      final profile = await _service.getProfile();
      final stats = await _service.getAttendanceStats();

      await prefs.setString(_kProfileCacheKey, jsonEncode(profile.toJson()));
      await prefs.setString(_kStatsCacheKey, jsonEncode(stats.toJson()));

      emit(ProfileLoaded(profile: profile, stats: stats));
    } on DioException catch (e) {
      debugPrint('[ProfileBloc] Network error: $e');
      if (!hasCache) {
        emit(ProfileError('Tidak ada koneksi internet.\nData profil belum tersedia.'));
      }
    } catch (e) {
      debugPrint('[ProfileBloc] Unknown error: $e');
      if (!hasCache) {
        emit(ProfileError('Gagal memuat data profil. Silakan coba lagi.'));
      }
    }
  }
}
