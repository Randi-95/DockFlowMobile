import 'package:art_sweetalert/art_sweetalert.dart'
    show ArtDialogResponse, ArtSweetAlert, ArtDialogArgs, ArtSweetAlertType;
import 'package:dockflow_app/core/storage/authstorage.dart';
import 'package:dockflow_app/features/profile/bloc/profile_bloc.dart';
import 'package:dockflow_app/features/profile/profile_service.dart';
import 'package:dockflow_app/features/profile/view/personal_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfileEvent()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003366)),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: Color(0xFF003366), size: 48),
                  const SizedBox(height: 16),
                  Text(state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF003366))),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProfileBloc>().add(LoadProfileEvent()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003366)),
                    child: const Text('Coba Lagi',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          final profile = (state as ProfileLoaded).profile;
          final stats = state.stats;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(profile),
                _buildAttendanceCard(stats),
                _buildMenuSection(context, profile),
                const SizedBox(height: 10),
                _buildLogoutSection(context),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildHeroSection(ProfileData profile) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
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
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      _formatRole(profile.role),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
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
                            decoration: BoxDecoration(
                              color: profile.isActive
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            profile.isActive ? "Aktif" : "Tidak Aktif",
                            style: const TextStyle(
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
    );
  }

  Widget _buildAttendanceCard(AttendanceStats stats) {
    final now = DateTime.now();
    final monthName = '${_monthId(now.month)} ${now.year}';
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    final periodEnd = '$lastDay ${_monthId(now.month)} ${now.year}';
    final percentDisplay =
        '${(stats.percentage * 100).toStringAsFixed(0)}%';

    return Transform.translate(
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
                    Icon(Icons.calendar_month,
                        size: 16, color: Colors.blue[800]),
                    const SizedBox(width: 4),
                    Text(
                      monthName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatusItem(
                    "${stats.totalPresent}",
                    "Hadir",
                    Icons.check_circle,
                    const Color(0xFFE8F5E9),
                    Colors.green,
                  ),
                  _buildStatusItem(
                    "${stats.totalLate}",
                    "Terlambat",
                    Icons.access_time_filled,
                    const Color(0xFFFFF3E0),
                    Colors.orange,
                  ),
                  _buildStatusItem(
                    "${stats.totalAbsent}",
                    "Tidak Hadir",
                    Icons.cancel,
                    const Color(0xFFFFEBEE),
                    Colors.red,
                  ),
                  _buildStatusItem(
                    "${stats.totalDayWork}",
                    "Total Hari Kerja",
                    Icons.calendar_today,
                    const Color(0xFFE3F2FD),
                    Colors.blue,
                  ),
                  _buildAttendanceProgress(
                      percentDisplay, "Tingkat Kehadiran", stats.percentage),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  "Periode: 1 - $periodEnd",
                  style:
                      TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
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

  Widget _buildAttendanceProgress(
      String percentage, String label, double value) {
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
                  value: value.clamp(0.0, 1.0),
                  strokeWidth: 4,
                  backgroundColor: Colors.blue[100],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
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


  Widget _buildMenuSection(BuildContext context, ProfileData profile) {
    return Container(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PersonalInfoPage(profile: profile),
                ),
              );
            },
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
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Container(
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
              denyButtonText: "Batal",
              title: "Konfirmasi Keluar?",
              text: "Apakah Anda yakin ingin keluar dari akun ini?",
              confirmButtonText: "Ya, Keluar",
              type: ArtSweetAlertType.warning,
              confirmButtonColor: Colors.red,
              denyButtonColor: Colors.blue,
            ),
          );

          if (!response.isTapConfirmButton) return;

          await AuthStorage.deleteToken();
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed('/loginpage');
          }
        },
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
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  String _formatRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return 'Administrator';
      case 'staff':
        return 'Staff Operasional';
      case 'manager':
        return 'Manager';
      case 'supervisor':
        return 'Supervisor';
      default:
        return role.isNotEmpty
            ? '${role[0].toUpperCase()}${role.substring(1)}'
            : 'Karyawan';
    }
  }

  String _monthId(int month) {
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month];
  }
}
