import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/history/history_bloc/history_bloc.dart';
import 'package:dockflow_app/features/history/view/upload_proof_page.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedStatus;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetHistoryEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF003366),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return Column(
              children: [
                _buildHeader(),
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
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFF003366),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is HistoryError) {
            return Column(
              children: [
                _buildHeader(),
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Color(0XFF003366),
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: Color(0XFF003366)),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HistoryBloc>().add(
                                GetHistoryEvent(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF003366),
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

          if (state is HistoryLoaded) {
            return Column(
              children: [
                _buildHeader(),
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
                        _buildTabBar(state.summary),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildSearchAndDatePicker(),
                                _buildSummaryGrid(state.summary),
                                _buildOrderList(state.bookings),
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
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildTabBar(summary) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            _tabItem("Semua", _selectedStatus == null, null),
            _tabItem("Menunggu", _selectedStatus == "waiting", "waiting"),
            _tabItem(
              "Dikonfirmasi",
              _selectedStatus == "confirmed",
              "confirmed",
            ),
            _tabItem("Diproses", _selectedStatus == "processing", "processing"),
            _tabItem(
              "Dikirim",
              _selectedStatus == "on_delivery",
              "on_delivery",
            ),
            _tabItem(
              "Menunggu Verifikasi",
              _selectedStatus == "pending_completion",
              "pending_completion",
            ),
            _tabItem("Selesai", _selectedStatus == "completed", "completed"),
            _tabItem("Dibatalkan", _selectedStatus == "cancelled", "cancelled"),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title, bool isActive, String? status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
        context.read<HistoryBloc>().add(FilterByStatusEvent(status: status));
      },
      child: Container(
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
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (_searchController.text == value) {
                      context.read<HistoryBloc>().add(
                        SearchBookingEvent(search: value),
                      );
                    }
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, size: 20, color: Colors.grey),
                  hintText: "Cari no. pesanan / kapal",
                  hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                setState(() {
                  _selectedDate = formattedDate;
                });
                context.read<HistoryBloc>().add(
                  FilterByDateEvent(date: formattedDate),
                );
              }
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid(summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem(
            Icons.access_time_filled,
            "Menunggu",
            "${summary.waiting}",
            Colors.blue,
          ),
          _summaryItem(
            Icons.check_circle,
            "Dikonfirmasi",
            "${summary.confirmed}",
            Colors.green,
          ),
          _summaryItem(
            Icons.settings,
            "Diproses",
            "${summary.processing}",
            Colors.orange,
          ),
          _summaryItem(
            Icons.directions_boat,
            "Selesai",
            "${summary.completed}",
            Colors.purple,
          ),
          _summaryItem(
            Icons.cancel,
            "Dibatalkan",
            "${summary.cancelled}",
            Colors.red,
          ),
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

  Widget _buildOrderList(List bookings) {
    if (bookings.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: const [
            Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Tidak ada riwayat pesanan",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _orderCard(booking);
      },
    );
  }

  Widget _orderCard(booking) {
    Color statusColor = _getStatusColor(booking.status);
    IconData statusIcon = _getStatusIcon(booking.status);
    String statusText = _getStatusText(booking.status);

    String formattedDate = "";
    try {
      final date = DateTime.parse(booking.createdAt);
      formattedDate = DateFormat('dd MMM yyyy • HH:mm').format(date);
    } catch (e) {
      formattedDate = booking.createdAt;
    }

    String formattedEstDate = "";
    if (booking.estimatedDeliveryDate != null) {
      try {
        final date = DateTime.parse(booking.estimatedDeliveryDate);
        formattedEstDate = DateFormat('dd MMM yyyy').format(date);
      } catch (e) {
        formattedEstDate = booking.estimatedDeliveryDate ?? "-";
      }
    }

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    String formattedPrice = formatter.format(booking.totalEstimatedPrice);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketPage(
              booking: booking,
              formattedDate: formattedDate,
              formattedEstDate: formattedEstDate,
              formattedPrice: formattedPrice,
              statusText: statusText,
              statusColor: statusColor,
            ),
          ),
        );
      },
      child: Container(
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(statusIcon, color: statusColor, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.bookingNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Color(0XFF003366),
                    ),
                  ),
                  Text(
                    booking.vesselName ?? "-",
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
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                      statusText,
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
                    formattedEstDate,
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
                    formattedPrice,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    "${booking.itemsCount} Item",
                    style: const TextStyle(fontSize: 7, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'processing':
        return Colors.orangeAccent;
      case 'on_delivery':
        return const Color(0xFF0052CC);
      case 'pending_completion':
        return Colors.amber.shade700;
      case 'completed':
        return Colors.purple;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Icons.access_time;
      case 'confirmed':
        return Icons.check_circle;
      case 'processing':
        return Icons.settings;
      case 'on_delivery':
        return Icons.local_shipping;
      case 'pending_completion':
        return Icons.hourglass_top;
      case 'completed':
        return Icons.directions_boat;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return 'Menunggu';
      case 'confirmed':
        return 'Dikonfirmasi';
      case 'processing':
        return 'Diproses';
      case 'on_delivery':
        return 'Dalam Pengiriman';
      case 'pending_completion':
        return 'Menunggu Verifikasi';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
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

class TicketPage extends StatefulWidget {
  final dynamic booking;
  final String formattedDate;
  final String formattedEstDate;
  final String formattedPrice;
  final String statusText;
  final Color statusColor;

  const TicketPage({
    Key? key,
    required this.booking,
    required this.formattedDate,
    required this.formattedEstDate,
    required this.formattedPrice,
    required this.statusText,
    required this.statusColor,
  }) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final formattedDate = widget.formattedDate;
    final formattedEstDate = widget.formattedEstDate;
    final formattedPrice = widget.formattedPrice;
    final statusText = widget.statusText;
    final statusColor = widget.statusColor;
    return Scaffold(
      backgroundColor: const Color(0XFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0XFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Pesanan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipPath(
                clipper: TicketClipper(),
                child: Column(
                  children: [
                    Container(
                      color: const Color(0XFF4A85F6),
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.shopping_bag,
                                  color: Color(0XFF4A85F6),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Nomor Pesanan",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      booking.bookingNumber,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                child: Text(
                                  statusText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(
                            Icons.assignment,
                            "Informasi Pesanan",
                          ),
                          const SizedBox(height: 15),
                          _buildInfoRow(
                            "Nama Kapal",
                            booking.vesselName ?? "-",
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                            "Alamat Dermaga",
                            booking.dockLocation ?? "-",
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow("Estimasi Tiba", formattedEstDate),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Color(0XFFF0F0F0)),
                          ),

                          _buildSectionTitle(
                            Icons.inventory_2_outlined,
                            "Detail Produk",
                          ),
                          const SizedBox(height: 15),
                          ...booking.items
                              .map<Widget>((item) => _buildProductItem(item))
                              .toList(),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Divider(color: Color(0XFFF0F0F0)),
                          ),

                          _buildSectionTitle(
                            Icons.receipt_long,
                            "Ringkasan Pembayaran",
                          ),
                          const SizedBox(height: 15),
                          _buildPaymentRow(
                            "Total Pembayaran",
                            formattedPrice,
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: Row(
                        children: List.generate(
                          40,
                          (index) => Expanded(
                            child: Container(
                              height: 1,
                              color: index.isEven
                                  ? Colors.transparent
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text(
                            "Tunjukkan barcode ini ke petugas",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (booking.barcodeUrl != null &&
                              booking.barcodeUrl!.isNotEmpty)
                            Image.network(
                              booking.barcodeUrl!,
                              height: 80,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.qr_code_scanner,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                            )
                          else
                            const Icon(
                              Icons.qr_code_scanner,
                              size: 80,
                              color: Colors.grey,
                            ),
                          const SizedBox(height: 10),
                          Text(
                            booking.bookingNumber.replaceAll('-', ''),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0XFFF0F5FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0XFFD6E4FF)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0XFF4A85F6),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: const Text(
                      "Simpan tiket ini atau tunjukkan ke petugas untuk memudahkan proses pengambilan.",
                      style: TextStyle(color: Color(0XFF4A85F6), fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (booking.status == 'on_delivery')
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003366),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  icon: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Upload Bukti Pengiriman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    final refreshed = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UploadProofPage(
                          bookingId: booking.id,
                          bookingNumber: booking.bookingNumber,
                        ),
                      ),
                    );
                    if (refreshed == true && context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ),

            if (booking.status == 'pending_completion') ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFFE082)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.hourglass_top,
                      color: Color(0xFFF59E0B),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Menunggu Verifikasi Admin',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF92400E),
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Bukti pengiriman sudah dikirim. Admin sedang memverifikasi pesanan Anda.',
                            style: TextStyle(
                              color: Color(0xFF92400E),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (booking.proofOfDeliveryUrl != null) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Bukti Pengiriman Diunggah:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    booking.proofOfDeliveryUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0XFF4A85F6)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(dynamic item) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    String formattedItemPrice = formatter.format(item.price);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0XFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.inventory_2, color: Colors.grey),
                    ),
                  )
                : const Icon(Icons.inventory_2, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Qty: ${item.qty}",
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedItemPrice,
                  style: const TextStyle(
                    color: Color(0XFF4A85F6),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? const Color(0XFF4A85F6) : Colors.grey,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 14 : 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? const Color(0XFF4A85F6) : Colors.black87,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 14 : 12,
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    const double radius = 6.0;
    const double notchRadius = 15.0;

    path.lineTo(0, 0);

    int count = (size.width / (radius * 2)).floor();
    double spacing = (size.width - (count * radius * 2)) / count;

    path.moveTo(0, 0);
    double currentX = 0;

    for (int i = 0; i < count; i++) {
      currentX += radius;

      if (i == count ~/ 2) {
        path.arcToPoint(
          Offset(currentX + notchRadius * 2, 0),
          radius: const Radius.circular(notchRadius),
          clockwise: false,
        );
        currentX += notchRadius * 2;
      } else {
        path.arcToPoint(
          Offset(currentX + radius, 0),
          radius: const Radius.circular(radius),
          clockwise: false,
        );
        currentX += radius;
      }

      if (i < count - 1) {
        path.lineTo(currentX + spacing, 0);
        currentX += spacing;
      }
    }

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height * 0.65 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height * 0.65 + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);

    currentX = size.width;
    for (int i = 0; i < count; i++) {
      currentX -= radius;
      path.arcToPoint(
        Offset(currentX - radius, size.height),
        radius: const Radius.circular(radius),
        clockwise: false,
      );
      currentX -= radius;

      if (i < count - 1) {
        path.lineTo(currentX - spacing, size.height);
        currentX -= spacing;
      }
    }

    path.lineTo(0, size.height);

    path.lineTo(0, size.height * 0.65 + notchRadius);
    path.arcToPoint(
      Offset(0, size.height * 0.65 - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
