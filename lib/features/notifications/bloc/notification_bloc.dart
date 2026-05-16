import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/notifications/models/notification_model.dart';
import 'package:dockflow_app/features/notifications/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await repository.getNotifications();
        emit(NotificationLoaded(notifications));
      } catch (e) {
        emit(NotificationError(e.toString()));
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
