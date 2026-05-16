part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class FetchNotifications extends NotificationEvent {}

class MarkNotificationAsRead extends NotificationEvent {
  final String id;
  MarkNotificationAsRead(this.id);
}

class MarkAllNotificationsAsRead extends NotificationEvent {}
