part of 'inventory_bloc.dart';

sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

final class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final InventoryStatistics statistics;
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final int? selectedCategoryId;
  final String? searchQuery;

  InventoryLoaded({
    required this.statistics,
    required this.categories,
    required this.products,
    this.selectedCategoryId,
    this.searchQuery,
  });

  InventoryLoaded copyWith({
    InventoryStatistics? statistics,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    int? selectedCategoryId,
    String? searchQuery,
  }) {
    return InventoryLoaded(
      statistics: statistics ?? this.statistics,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class InventoryError extends InventoryState {
  final String message;

  InventoryError({required this.message});
}
