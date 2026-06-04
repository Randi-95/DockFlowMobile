import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/inventory/inventory_models/category_model.dart';
import 'package:dockflow_app/features/inventory/inventory_models/inventory_statistics.dart';
import 'package:dockflow_app/features/inventory/inventory_models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final apiClient = ApiClient();

  InventoryBloc() : super(InventoryInitial()) {
    on<GetInventoryEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> queryParams = {};
        
      if (event.search != null && event.search!.isNotEmpty) {
        queryParams['search'] = event.search;
      }
      
      if (event.categoryId != null) {
        queryParams['category_id'] = event.categoryId;
      }

      final cacheKey = 'inventory_data_${queryParams.toString()}';

      final cachedString = prefs.getString(cacheKey);
      bool hasCache = false;

      if (cachedString != null) {
        try {
          final cachedData = jsonDecode(cachedString);
          final statistics = InventoryStatistics.fromJson(cachedData['statistics']);
          
          final categories = (cachedData['categories'] as List)
              .map((cat) => CategoryModel.fromJson(cat))
              .toList();
          
          final products = (cachedData['products'] as List)
              .map((prod) => ProductModel.fromJson(prod))
              .toList();

          emit(InventoryLoaded(
            statistics: statistics,
            categories: categories,
            products: products,
            selectedCategoryId: event.categoryId,
            searchQuery: event.search,
          ));
          hasCache = true;
        } catch (e) {
        }
      }

      if (!hasCache) {
        emit(InventoryLoading());
      }

      try {
        final response = await apiClient.dio.get(
          '/inventory-data',
          queryParameters: queryParams,
        );

        if (response.data['status'] == true) {
          final data = response.data['data'];

          await prefs.setString(cacheKey, jsonEncode(data));

          final statistics = InventoryStatistics.fromJson(data['statistics']);
          
          final categories = (data['categories'] as List)
              .map((cat) => CategoryModel.fromJson(cat))
              .toList();
          
          final products = (data['products'] as List)
              .map((prod) => ProductModel.fromJson(prod))
              .toList();

          emit(InventoryLoaded(
            statistics: statistics,
            categories: categories,
            products: products,
            selectedCategoryId: event.categoryId,
            searchQuery: event.search,
          ));
        } else {
          if (!hasCache) {
            emit(InventoryError(message: "Gagal memuat data inventory"));
          }
        }
      } on DioException catch (e) {
        if (!hasCache) {
          String errorMsg = "Terjadi kesalahan koneksi";

          if (e.response != null) {
            errorMsg = e.response?.data['message'] ?? "Gagal memuat data";
          }

          emit(InventoryError(message: errorMsg));
        }
      }
    });

    on<FilterByCategoryEvent>((event, emit) {
      add(GetInventoryEvent(categoryId: event.categoryId));
    });

    on<SearchProductEvent>((event, emit) {
      add(GetInventoryEvent(search: event.search));
    });
  }
}
