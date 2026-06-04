import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/checkout/models/vessel_model.dart';

class CheckoutService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Vessel>> getVessels() async {
    try {
      final response = await _apiClient.dio.get('/vessels');
      if (response.statusCode == 200 && response.data['status'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Vessel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch vessels: $e');
    }
  }

  Future<bool> checkout(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post('/checkout', data: data);
      if (response.statusCode == 201 && response.data['status'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to checkout: $e');
    }
  }
}
