import 'dart:convert';

BookingSummary bookingSummaryFromJson(String str) =>
    BookingSummary.fromJson(json.decode(str));

String bookingSummaryToJson(BookingSummary data) =>
    json.encode(data.toJson());

class BookingSummary {
  final int waiting;
  final int confirmed;
  final int processing;
  final int completed;
  final int cancelled;

  BookingSummary({
    required this.waiting,
    required this.confirmed,
    required this.processing,
    required this.completed,
    required this.cancelled,
  });

  int get total => waiting + confirmed + processing + completed + cancelled;

  factory BookingSummary.fromJson(Map<String, dynamic> json) =>
      BookingSummary(
        waiting: json["waiting"] ?? 0,
        confirmed: json["confirmed"] ?? 0,
        processing: json["processing"] ?? 0,
        completed: json["completed"] ?? 0,
        cancelled: json["cancelled"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "waiting": waiting,
        "confirmed": confirmed,
        "processing": processing,
        "completed": completed,
        "cancelled": cancelled,
      };
}
