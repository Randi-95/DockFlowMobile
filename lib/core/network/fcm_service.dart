import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dockflow_app/core/network/api_client.dart';
import 'package:dockflow_app/core/storage/authstorage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final ApiClient _apiClient = ApiClient();
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<void> initNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print("FCM Token: $token");

      await saveTokenToBackend(token);
    }

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("FCM Token Refreshed: $newToken");
      saveTokenToBackend(newToken);
    });
  }

  Future<void> updateToken() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await saveTokenToBackend(token);
    }
  }

  Future<void> saveTokenToBackend(String fcmToken) async {
    try {
      final authToken = await AuthStorage.readToken();
      final userId = await AuthStorage.readUserId();
      
      if (authToken == null || userId == null) {
        print("Not logged in, skip saving FCM token");
        return;
      }

      String deviceId = "unknown";
      String deviceName = "Unknown Device";

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceId = androidInfo.id; 
        deviceName = "${androidInfo.brand} ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? "unknown_ios";
        deviceName = iosInfo.name;
      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsInfo = await _deviceInfo.windowsInfo;
        deviceId = windowsInfo.deviceId;
        deviceName = windowsInfo.computerName;
      }

      print("Attempting to save FCM token for user $userId on device $deviceId");

      final response = await _apiClient.dio.post(
        '/save-token',
        data: {
          'user_id': userId,
          'device_id': deviceId,
          'fcm_token': fcmToken,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200) {
        print("FCM Token saved successfully: ${response.data}");
      } else {
        print("Failed to save FCM token: ${response.data}");
      }
    } catch (e) {
      print("Error saving FCM token: $e");
    }
  }
}
