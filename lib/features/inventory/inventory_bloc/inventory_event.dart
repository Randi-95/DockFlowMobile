part of 'inventory_bloc.dart';

sealed class InventoryEvent {}

class GetInventoryEvent extends InventoryEvent {
  final String? search;
  final int? categoryId;

  GetInventoryEvent({this.search, this.categoryId});
}

class FilterByCategoryEvent extends InventoryEvent {
  final int? categoryId;

  FilterByCategoryEvent({this.categoryId});
}

class SearchProductEvent extends InventoryEvent {
  final String search;

  SearchProductEvent({required this.search});
}
