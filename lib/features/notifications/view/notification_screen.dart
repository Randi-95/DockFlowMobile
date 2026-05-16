import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/notifications/bloc/notification_bloc.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: AppBar(
          title: const Text(
            'Notifikasi',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          actions: [
            TextButton(
              onPressed: () {
                context.read<NotificationBloc>().add(MarkAllNotificationsAsRead());
              },
              child: const Text(
                'Tandai semua dibaca',
                style: TextStyle(
                  color: Color(0xFF1565C0),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Color(0xFF1565C0),
                indicatorWeight: 3,
                labelColor: Color(0xFF1565C0),
                unselectedLabelColor: Color(0xFF9E9E9E),
                labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                tabs: [
                  Tab(text: 'Semua'),
                  Tab(text: 'Belum Dibaca'),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              final allNotifications = state.notifications;
              final unreadNotifications = allNotifications.where((n) => !n.isRead).toList();

              return TabBarView(
                children: [
                  _buildNotificationList(context, allNotifications),
                  _buildNotificationList(context, unreadNotifications),
                ],
              );
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context, List<NotificationModel> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_none_rounded, size: 64, color: Colors.blue.withOpacity(0.4)),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tidak ada notifikasi',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Semua notifikasi baru akan muncul di sini',
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotificationBloc>().add(FetchNotifications());
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _NotificationItem(notification: notification);
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!notification.isRead) {
          context.read<NotificationBloc>().add(MarkNotificationAsRead(notification.id));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.transparent : const Color(0xFFE3F2FD).withOpacity(0.3),
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: notification.isRead ? const Color(0xFFF5F5F5) : const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: notification.isRead ? const Color(0xFF757575) : const Color(0xFF1565C0),
                    size: 24,
                  ),
                ),
                if (!notification.isRead)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.w800,
                          fontSize: 15,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      Text(
                        _getTimeAgo(notification.createdAt),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body,
                    style: TextStyle(
                      color: const Color(0xFF424242),
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}j';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}h';
    } else {
      return DateFormat('dd/MM').format(date);
    }
  }
}
