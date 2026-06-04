import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/features/notifications/models/notification_model.dart';

class NotificationRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await _apiClient.dio.get('/notifications');
      
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _apiClient.dio.post('/notifications/mark-as-read/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _apiClient.dio.post('/notifications/mark-all-as-read');
    } catch (e) {
      rethrow;
    }
  }
}
