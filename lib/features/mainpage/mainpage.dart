import 'package:dockflow_app/features/home/view/home.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            currentIndex: 0, // Indeks yang aktif
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
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

      body: HomePage(),
    );
  }
}
