import 'package:dockflow_app/features/history/view/history_page.dart';
import 'package:dockflow_app/features/home/home_bloc/home_bloc.dart';
import 'package:dockflow_app/features/home/view/home.dart';
import 'package:dockflow_app/features/inventory/view/inventory_page.dart';
import 'package:dockflow_app/features/profile/profile.dart';
import 'package:dockflow_app/core/network/fcm_service.dart';
import 'package:dockflow_app/features/notifications/view/notification_screen.dart';
import 'package:dockflow_app/features/notifications/bloc/notification_bloc.dart';
import 'package:dockflow_app/features/notifications/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> screen = [
    const HomePage(),
    const InventoryPage(),
    const OrderHistoryPage(),
    const NotificationScreen(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();    
    FCMService().updateToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()..add(GetHomeEvent())),
        BlocProvider(
          create: (context) => NotificationBloc(
            repository: NotificationRepository(),
          )..add(FetchNotifications()),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF1565C0),
              unselectedItemColor: Colors.blueGrey[400],
              currentIndex: _currentIndex,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              showUnselectedLabels: true,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Column(
                      children: [
                        Icon(Icons.home_rounded, size: 28),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  label: 'Beranda',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  label: 'Inventory',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: const Text('3'),
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.notifications_none_rounded),
                  ),
                  label: 'Notifikasi',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),

        body: screen[_currentIndex],
      ),
    );
  }
}
