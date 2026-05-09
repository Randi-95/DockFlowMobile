import 'package:art_sweetalert/art_sweetalert.dart'
    show ArtDialogResponse, ArtSweetAlert, ArtDialogArgs, ArtSweetAlertType;
import 'package:dockflow_app/core/storage/authstorage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Banner Background
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      'assets/images/bannerprofile.png',
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 2. Logo di Pojok Atas (Manual)
                Positioned(
                  top: 30,
                  left: 20,
                  child: Image.asset(
                    'assets/images/logomentahan.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: 110,
                  left: 25,
                  right: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: const CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Randi Permana Shidiq",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Text(
                              "Software Engineer",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Badge Aktif
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF001F3F).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Aktif",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Judul dan Dropdown Bulan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Performa Kehadiran - Bulan Ini",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF002366),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: Colors.blue[800],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Mei 2026",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: Colors.blue[800],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Baris Kotak Status
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildStatusItem(
                            "21",
                            "Hadir",
                            Icons.check_circle,
                            const Color(0xFFE8F5E9),
                            Colors.green,
                          ),
                          _buildStatusItem(
                            "2",
                            "Terlambat",
                            Icons.access_time_filled,
                            const Color(0xFFFFF3E0),
                            Colors.orange,
                          ),
                          _buildStatusItem(
                            "1",
                            "Tidak Hadir",
                            Icons.cancel,
                            const Color(0xFFFFEBEE),
                            Colors.red,
                          ),
                          _buildStatusItem(
                            "24",
                            "Total Hari Kerja",
                            Icons.calendar_today,
                            const Color(0xFFE3F2FD),
                            Colors.blue,
                          ),
                          _buildAttendanceProgress("92%", "Tingkat Kehadiran"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Footer: Periode
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Periode: 1 - 31 Mei 2026",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 1. Menu Pengaturan Utama
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: "Informasi Pribadi",
                    subtitle: "Lihat dan kelola informasi akun Anda",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildMenuItem(
                    icon: Icons.badge_outlined,
                    title: "Informasi Pekerjaan",
                    subtitle: "Detail posisi, divisi, dan informasi kerja",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildMenuItem(
                    icon: Icons.shield_outlined,
                    title: "Keamanan Akun",
                    subtitle: "Ubah password dan pengaturan keamanan",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildMenuItem(
                    icon: Icons.notifications_none_outlined,
                    title: "Pengaturan",
                    subtitle: "Notifikasi, bahasa, dan preferensi aplikasi",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: "Bantuan & Dukungan",
                    subtitle: "FAQ, panduan, dan hubungi tim support",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 70),
                  _buildMenuItem(
                    icon: Icons.info_outline_rounded,
                    title: "Tentang Aplikasi",
                    subtitle: "Versi aplikasi dan informasi perusahaan",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 2. Tombol Keluar (Terpisah)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _buildMenuItem(
                icon: Icons.logout_rounded,
                title: "Keluar",
                subtitle: "Keluar dari akun Anda",
                isLogout: true,
                onTap: () async {
                  ArtDialogResponse response = await ArtSweetAlert.show(
                    barrierDismissible: false,
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                      denyButtonText: "Cancel",
                      title: "Konfirmasi Keluar?",
                      text: "Apakah Anda yakin ingin keluar dari akun ini?",
                      confirmButtonText: "Ya, Keluar",
                      type: ArtSweetAlertType.warning,
                      confirmButtonColor: Colors.red,
                      denyButtonColor: Colors.blue
                    ),
                  );

                  if (response == null) {
                    return ;
                  }

                  if (response.isTapConfirmButton) {
                    await AuthStorage.deleteToken();
                    Navigator.of(context).pushReplacementNamed('/loginpage');
                    return;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isLogout ? Colors.red[50] : const Color(0xFFF5F9FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isLogout ? Colors.red : const Color(0xFF002366),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isLogout ? Colors.red : const Color(0xFF002366),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap
    );
  }

  Widget _buildStatusItem(
    String value,
    String label,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk indikator persentase (Tingkat Kehadiran)
  Widget _buildAttendanceProgress(String percentage, String label) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: 4,
                  backgroundColor: Colors.blue[100],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                ),
              ),
              Text(
                percentage,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
