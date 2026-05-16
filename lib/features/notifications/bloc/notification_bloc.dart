import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dockflow_app/features/notifications/models/notification_model.dart';
import 'package:dockflow_app/features/notifications/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;
  static const String _cacheKey = 'cached_notifications';

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      final cachedString = prefs.getString(_cacheKey);
      bool hasCache = false;

      if (cachedString != null) {
        try {
          final List cachedData = jsonDecode(cachedString);
          final notifications = cachedData
              .map((json) => NotificationModel.fromJson(json))
              .toList();
          
          emit(NotificationLoaded(notifications));
          hasCache = true;
        } catch (e) {
        }
      }

      if (!hasCache) {
        emit(NotificationLoading());
      }
      try {
        final notifications = await repository.getNotifications();
        
        await prefs.setString(_cacheKey, jsonEncode(notifications.map((e) => e.toJson()).toList()));
        
        emit(NotificationLoaded(notifications));
      } catch (e) {
        if (!hasCache) {
          emit(NotificationError(e.toString()));
        }
      }
    });

    on<MarkNotificationAsRead>((event, emit) async {
      try {  
        await repository.markAsRead(event.id);
        
        if (state is NotificationLoaded) {
          final currentNotifications = (state as NotificationLoaded).notifications;
          final updatedNotifications = currentNotifications.map((n) {
            if (n.id == event.id) {
              return NotificationModel(
                id: n.id,
                type: n.type,
                title: n.title,
                body: n.body,
                readAt: DateTime.now(),
                createdAt: n.createdAt,
              );
            }
            return n;
          }).toList();

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_cacheKey, jsonEncode(updatedNotifications.map((e) => e.toJson()).toList()));

          emit(NotificationLoaded(updatedNotifications));
        }
      } catch (e) {
      }
    });

    on<MarkAllNotificationsAsRead>((event, emit) async {
      try {
        await repository.markAllAsRead();
        add(FetchNotifications());
      } catch (e) {
        
      }
    });
  }
}
