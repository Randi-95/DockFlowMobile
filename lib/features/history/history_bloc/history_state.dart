part of 'history_bloc.dart';

sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final BookingSummary summary;
  final List<BookingModel> bookings;
  final String? selectedStatus;
  final String? searchQuery;
  final String? selectedDate;

  HistoryLoaded({
    required this.summary,
    required this.bookings,
    this.selectedStatus,
    this.searchQuery,
    this.selectedDate,
  });

  HistoryLoaded copyWith({
    BookingSummary? summary,
    List<BookingModel>? bookings,
    String? selectedStatus,
    String? searchQuery,
    String? selectedDate,
  }) {
    return HistoryLoaded(
      summary: summary ?? this.summary,
      bookings: bookings ?? this.bookings,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}
