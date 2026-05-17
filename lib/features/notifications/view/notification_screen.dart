import 'package:dockflow_app/features/notifications/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/notifications/bloc/notification_bloc.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FBFE),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF003366),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is NotificationError) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FBFE),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Color(0xFF003366),
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: Color(0xFF003366)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<NotificationBloc>()
                                  .add(FetchNotifications());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF003366),
                            ),
                            child: const Text(
                              'Coba Lagi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is NotificationLoaded) {
            final allNotifications = state.notifications;
            final unreadNotifications =
                allNotifications.where((n) => !n.isRead).toList();
            final unreadCount = unreadNotifications.length;

            return Column(
              children: [
                _buildHeader(unreadCount: unreadCount),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FBFE),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildTabBar(unreadCount),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildNotificationList(
                                  context, allNotifications),
                              _buildNotificationList(
                                  context, unreadNotifications),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FBFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader({int unreadCount = 0}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Notifikasi",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unreadCount > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "$unreadCount belum dibaca",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<NotificationBloc>()
                      .add(MarkAllNotificationsAsRead());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.done_all, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        "Tandai Semua",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Pantau semua pemberitahuan terkait\npesanan dan aktivitas Anda.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(int unreadCount) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: const Color(0xFF0052CC),
        indicatorWeight: 3,
        labelColor: const Color(0xFF0052CC),
        unselectedLabelColor: Colors.grey,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        tabs: [
          const Tab(text: 'Semua'),
          Tab(
            child: Row(
              children: [
                const Text('Belum Dibaca'),
                if (unreadCount > 0) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0052CC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
      BuildContext context, List<NotificationModel> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF003366).withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 64,
                color: const Color(0xFF003366).withOpacity(0.35),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tidak ada notifikasi',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Semua notifikasi baru akan muncul di sini',
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFF003366),
      onRefresh: () async {
        context.read<NotificationBloc>().add(FetchNotifications());
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
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
          context
              .read<NotificationBloc>()
              .add(MarkNotificationAsRead(notification.id));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : const Color(0xFFE8F2FF).withOpacity(0.6),
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
                    color: notification.isRead
                        ? const Color(0xFFF5F5F5)
                        : const Color(0xFFDCEAFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: notification.isRead
                        ? const Color(0xFF9E9E9E)
                        : const Color(0xFF0052CC),
                    size: 22,
                  ),
                ),
                if (!notification.isRead)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead
                                ? FontWeight.w600
                                : FontWeight.w800,
                            fontSize: 14,
                            color: const Color(0xFF003366),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
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
                  const SizedBox(height: 5),
                  Text(
                    notification.body,
                    style: TextStyle(
                      color: const Color(0xFF555555),
                      fontSize: 13,
                      height: 1.45,
                      fontWeight: notification.isRead
                          ? FontWeight.w400
                          : FontWeight.w500,
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
