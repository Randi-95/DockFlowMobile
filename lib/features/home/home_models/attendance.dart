import 'dart:convert';

Attendance attendanceFromJson(String str) => Attendance.fromJson(json.decode(str));

String attendanceToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
    final int totalPresent;
    final int totalLate;
    final int totalAbsent;
    final int totalDayWork;
    final double percentage;

    Attendance({
        required this.totalPresent,
        required this.totalLate,
        required this.totalAbsent,
        required this.totalDayWork,
        required this.percentage,
    });

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        totalPresent: json["totalPresent"],
        totalLate: json["totalLate"],
        totalAbsent: json["totalAbsent"],
        totalDayWork: json["totalDayWork"],
        percentage: json["percentage"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "totalPresent": totalPresent,
        "totalLate": totalLate,
        "totalAbsent": totalAbsent,
        "totalDayWork": totalDayWork,
        "percentage": percentage,
    };
}
