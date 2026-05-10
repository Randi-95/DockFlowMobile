part of 'history_bloc.dart';

sealed class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {
  final String? status;
  final String? search;
  final String? date;

  GetHistoryEvent({this.status, this.search, this.date});
}

class FilterByStatusEvent extends HistoryEvent {
  final String? status;

  FilterByStatusEvent({this.status});
}

class SearchBookingEvent extends HistoryEvent {
  final String search;

  SearchBookingEvent({required this.search});
}

class FilterByDateEvent extends HistoryEvent {
  final String date;

  FilterByDateEvent({required this.date});
}
