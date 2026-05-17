import 'package:flutter/material.dart';

class JobInfoPage extends StatelessWidget {
  const JobInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informasi Pekerjaan',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF003366),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Panduan Operasional',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kru Lapangan',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Boarding Officer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildCard(
              children: [
                _sectionLabel('Deskripsi Peran'),
                const SizedBox(height: 10),
                _bodyText(
                  'Sebagai Kru Lapangan, Anda adalah ujung tombak perusahaan. '
                  'Tugas utama Anda adalah memastikan barang logistik (Deck Store, Engine Store, Provisions) '
                  'yang telah disiapkan oleh tim gudang sampai ke tangan Kapten Kapal dengan aman, tepat waktu, dan tervalidasi.',
                ),
              ],
            ),

            const SizedBox(height: 14),

            _buildCard(
              children: [
                _sectionLabel('Prosedur Kerja Harian'),
                const SizedBox(height: 16),
                _buildStep(
                  number: '1',
                  title: 'Presensi Kehadiran (Tap-In)',
                  body: 'Mulailah hari kerja dengan menempelkan ID Card (RFID) pada alat pemindai di Station Gudang.\n\n'
                      'Batas Waktu Hadir: Pukul 08:00 WIB. Tap di atas jam tersebut akan tercatat sebagai Terlambat di sistem HR.',
                ),
                _divider(),
                _buildStep(
                  number: '2',
                  title: 'Cek & Ambil Muatan',
                  body: 'Buka menu "Inventory / Pesanan" di aplikasi. Perhatikan pesanan dengan status Processing — '
                      'artinya barang sudah selesai di-scan (Picking & Packing) oleh Admin Gudang dan siap dimuat ke kendaraan.',
                ),
                _divider(),
                _buildStep(
                  number: '3',
                  title: 'Pengantaran ke Lokasi',
                  body: 'Cek detail pesanan untuk mengetahui posisi kapal klien (misal: Dermaga A atau Anchorage Area). '
                      'Pastikan Anda membawa Surat Jalan (Delivery Note) yang sudah dicetak dari kantor.',
                ),
                _divider(),
                _buildStep(
                  number: '4',
                  title: 'Serah Terima (Bukti Pengiriman)',
                  body: 'Serahkan barang kepada Kapten Kapal atau Chief Engineer. '
                      'Mintalah Tanda Tangan dan Stempel Kapal pada fisik kertas Surat Jalan.',
                ),
                _divider(),
                _buildStep(
                  number: '5',
                  title: 'Konfirmasi Selesai di Aplikasi',
                  body: 'Buka aplikasi DockFlow, masuk ke detail pesanan, lalu tekan "Selesaikan Pesanan". '
                      'Ambil foto Surat Jalan yang sudah ditandatangani sebagai Bukti Pengiriman (Proof of Delivery).\n\n'
                      'Catatan: Jika tidak ada sinyal di laut, tetap tekan Selesai. Sistem memiliki fitur Offline-Sync '
                      'yang otomatis mengirim data saat Anda kembali ke darat.',
                ),
              ],
            ),

            const SizedBox(height: 14),

            _buildCard(
              children: [
                _sectionLabel('Aturan Keselamatan Kerja'),
                const SizedBox(height: 6),
                _bodyText(
                    'Kawasan pelabuhan dan dek kapal adalah area berisiko tinggi. '
                    'Anda diwajibkan menggunakan Alat Pelindung Diri (APD) selama bertugas:'),
                const SizedBox(height: 12),
                _buildBullet('Helm Keselamatan (Safety Helmet)'),
                _buildBullet('Rompi Reflektor (High-Visibility Vest)'),
                _buildBullet('Sepatu Keselamatan (Safety Shoes)'),
              ],
            ),

            const SizedBox(height: 14),

            _buildCard(
              children: [
                _sectionLabel('Indikator Penilaian Kinerja (KPI)'),
                const SizedBox(height: 6),
                _bodyText(
                    'Performa Anda dievaluasi oleh sistem dan Manajer melalui Dashboard Pusat:'),
                const SizedBox(height: 12),
                _buildKpiItem(
                  title: 'Tingkat Kehadiran (%)',
                  desc: 'Kedisiplinan melakukan tap RFID tepat waktu.',
                ),
                const SizedBox(height: 10),
                _buildKpiItem(
                  title: 'Kecepatan & Akurasi',
                  desc: 'Waktu tempuh pengiriman dan ketepatan bukti Surat Jalan yang diunggah.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF9E9E9E),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF4A4A4A),
        height: 1.6,
      ),
    );
  }

  Widget _divider() => const Divider(
        height: 24,
        color: Color(0xFFF0F0F0),
      );

  Widget _buildStep({
    required String number,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(
            color: Color(0xFF003366),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 6),
              _bodyText(body),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF003366),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A4A4A),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiItem({required String title, required String desc}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B6B6B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
