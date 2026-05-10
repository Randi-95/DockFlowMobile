import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF003366),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Riwayat Pemesanan",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.tune, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text(
                            "Filter",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Lihat semua riwayat booking barang yang telah\ndilakukan.",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  _buildTabBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildSearchAndDatePicker(),
                          _buildSummaryGrid(),
                          _buildOrderList(),
                          _buildRepeatOrderBanner(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            _tabItem("Semua", true),
            _tabItem("Menunggu", false),
            _tabItem("Dikonfirmasi", false),
            _tabItem("Diproses", false),
            _tabItem("Selesai", false),
            _tabItem("Dibatalkan", false),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? const Color(0XFF0052CC) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
          color: isActive ? const Color(0XFF0052CC) : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSearchAndDatePicker() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0XFFF9FBFE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, size: 20, color: Colors.grey),
                  hintText: "Cari no. pesanan / kapal / barang",
                  hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text("Pilih Tanggal", style: TextStyle(fontSize: 11)),
                Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem(Icons.access_time_filled, "Menunggu", "4", Colors.blue),
          _summaryItem(Icons.check_circle, "Dikonfirmasi", "8", Colors.green),
          _summaryItem(Icons.settings, "Diproses", "6", Colors.orange),
          _summaryItem(Icons.directions_boat, "Selesai", "18", Colors.purple),
          _summaryItem(Icons.cancel, "Dibatalkan", "2", Colors.red),
        ],
      ),
    );
  }

  Widget _summaryItem(IconData icon, String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
        Text(
          count,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Pesanan",
          style: TextStyle(fontSize: 8, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildOrderList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      children: [
        _orderCard(
          "DFMS-2505-00124",
          "MV Ocean Star",
          "22 Mei 2025 • 10:30",
          "Menunggu",
          "23 Mei 2025",
          "5",
          "4.850.000",
          Colors.orange,
        ),
        _orderCard(
          "DFMS-2505-00118",
          "MT Pacific Glory",
          "20 Mei 2025 • 14:15",
          "Dikonfirmasi",
          "21 Mei 2025",
          "7",
          "7.230.000",
          Colors.green,
        ),
        _orderCard(
          "DFMS-2505-00110",
          "MV Samudera Raya",
          "18 Mei 2025 • 09:45",
          "Diproses",
          "19 Mei 2025",
          "9",
          "6.120.000",
          Colors.orangeAccent,
        ),
        _orderCard(
          "DFMS-2505-00095",
          "MV Sejati Abadi",
          "15 Mei 2025 • 16:20",
          "Selesai",
          "16 Mei 2025",
          "6",
          "3.760.000",
          Colors.purple,
        ),
      ],
    );
  }

  Widget _orderCard(
    String id,
    String boat,
    String date,
    String status,
    String est,
    String items,
    String price,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Status
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.access_time, color: statusColor, size: 20),
          ),
          const SizedBox(width: 10),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Color(0XFF003366),
                  ),
                ),
                Text(
                  boat,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 8,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(fontSize: 8, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Kolom Status & Estimasi - Dibungkus Expanded
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Estimasi",
                  style: TextStyle(fontSize: 7, color: Colors.grey),
                ),
                Text(
                  est,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF0052CC),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Kolom Harga - Dibungkus Expanded
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 7, color: Colors.grey),
                ),
                Text(
                  "Rp $price",
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                const Text(
                  "5 Item",
                  style: TextStyle(fontSize: 7, color: Colors.grey),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildRepeatOrderBanner() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0XFFF0F7FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.assignment_turned_in_outlined,
            color: Colors.blue,
            size: 40,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Butuh Pesanan yang Sama?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
                Text(
                  "Gunakan fitur repeat order untuk memesan kembali barang yang pernah dipesan.",
                  style: TextStyle(fontSize: 9, color: Colors.grey),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0XFF0052CC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.history, size: 14),
                SizedBox(width: 5),
                Text("Repeat Order", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
