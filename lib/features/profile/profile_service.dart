import 'package:dockflow_app/core/network/api_client.dart';

class ProfileData {
  final String name;
  final String email;
  final String role;
  final String employeeId;
  final int isActive;
  final int bookingActive;

  ProfileData({
    required this.name,
    required this.email,
    required this.role,
    required this.employeeId,
    required this.isActive,
    required this.bookingActive,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json, int bookingActive) {
    return ProfileData(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      employeeId: json['employee_id'] ?? '',
      isActive: json['is_active'] ?? 0,
      bookingActive: bookingActive,
    );
  }
}

class AttendanceStats {
  final int totalPresent;
  final int totalLate;
  final int totalAbsent;
  final int totalDayWork;
  final double percentage;

  AttendanceStats({
    required this.totalPresent,
    required this.totalLate,
    required this.totalAbsent,
    required this.totalDayWork,
    required this.percentage,
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) {
    return AttendanceStats(
      totalPresent: json['totalPresent'] ?? 0,
      totalLate: json['totalLate'] ?? 0,
      totalAbsent: json['totalAbsent'] ?? 0,
      totalDayWork: json['totalDayWork'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}

class ProfileService {
  final ApiClient _apiClient = ApiClient();

  Future<ProfileData> getProfile() async {
    final response = await _apiClient.dio.get('/profile');
    final data = response.data;
    return ProfileData.fromJson(
      data['data'],
      data['bookingActive'] ?? 0,
    );
  }

  Future<AttendanceStats> getAttendanceStats() async {
    final response = await _apiClient.dio.get('/get-statistik');
    return AttendanceStats.fromJson(response.data);
  }
}
