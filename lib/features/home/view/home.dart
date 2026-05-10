import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dockflow_app/features/home/home_bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is HomeLoaded) {
          final user = state.user;
          final stock = state.stok;
          final attendance = state.attendance;
          final percent = (attendance.percentage * 100).toStringAsFixed(0);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Header banner
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Image.asset(
                            'assets/images/banner.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 160, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo ${user.name}👋🏻',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'Semangat bekerja hari ini!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 210, 8, 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: const Color(0XFFF9FBFE),
                            elevation: 0.2,
                            child: Container(
                              margin: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.info,
                                            color: Color(0XFF0157BE),
                                            size: 22,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pemesanan hanya melalui kru',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF002366),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 170,
                                                child: Text(
                                                  'Untuk menjaga akurasi operasional dan kebutuhan konsultasi teknis, pemesanan barang tidak dapat dilakukan oleh pihak kapal (klien).',
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/images/fototask.png',
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Statistic cards
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Stok Tersedia
                        Expanded(
                          child: Card(
                            color: const Color(0XFFF5F8FE),
                            elevation: 0.1,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        color: Colors.blue,
                                        child: Container(
                                          margin: const EdgeInsets.all(6),
                                          child: const Icon(
                                            Icons.inventory_2_sharp,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Stok Tersedia',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                255,
                                                39,
                                                111,
                                                255,
                                              ),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${stock.totalItem}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0XFF002366),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const Text(
                                            'Item',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Lihat Inventory',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0XFF002366),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 12,
                                        color: Color(0XFF002366),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Pesanan Aktif
                        Expanded(
                          child: Card(
                            color: const Color(0XFFF2FBF7),
                            elevation: 0.1,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        color: const Color(0XFF378780),
                                        child: Container(
                                          margin: const EdgeInsets.all(6),
                                          child: const Icon(
                                            Icons.inventory_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Pesanan Aktif',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF378780),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Pesanan',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Lihat Detail',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0XFF378780),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 12,
                                        color: Color(0XFF378780),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Real-time stock info
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Card(
                      color: const Color(0XFF013367),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  color: const Color(0XFF013367),
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.inventory,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Stok Gudang Real-time',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        'Data stok selalu diperbarui secara real-time pastikan informasi akurat sebelum booking',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              color: const Color.fromARGB(255, 0, 43, 88),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.circle,
                                      size: 5,
                                      color: Color.fromARGB(255, 93, 250, 99),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Real-time',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Attendance statistics
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                    child: Card(
                      color: const Color(0XFFF9FBFE),
                      elevation: 0.3,
                      shadowColor: const Color.fromARGB(255, 220, 218, 218),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 12, 3, 12),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.date_range_outlined,
                                        size: 14,
                                        color: Color(0XFF013367),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Performa Kehadiran - 1 Bulan Terakhir',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0XFF013367),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Lihat Detail',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0XFF013367),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 12,
                                        color: Color(0XFF013367),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.8,
                              children: [
                                // Hadir
                                Card(
                                  color: const Color(0XFFF3FBF7),
                                  elevation: 0.1,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          '${attendance.totalPresent}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF013367),
                                          ),
                                        ),
                                        const Text(
                                          'Hadir',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Telat
                                Card(
                                  color: const Color(0XFFFDF9F1),
                                  elevation: 0.1,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          color: Colors.yellow[800],
                                        ),
                                        Text(
                                          '${attendance.totalLate}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF013367),
                                          ),
                                        ),
                                        const Text(
                                          'Telat',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Absen
                                Card(
                                  color: const Color(0XFFFEF4F2),
                                  elevation: 0.1,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          '${attendance.totalAbsent}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF013367),
                                          ),
                                        ),
                                        const Text(
                                          'Absen',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Total Hari Kerja
                                Card(
                                  color: const Color(0XFFF3F8FE),
                                  elevation: 0.1,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.groups_rounded,
                                          color: Colors.blue[800],
                                        ),
                                        Text(
                                          '${attendance.totalDayWork}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF013367),
                                          ),
                                        ),
                                        const Text(
                                          'Hari Kerja',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Tingkat Kehadiran',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Column(
                                        children: [
                                          Text(
                                            "${percent}%",
                                            style: const TextStyle(
                                              // Kamu bisa pindahkan const ke sini karena stylenya tetap
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF003998),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 10),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: attendance.percentage,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.blue[700]!,
                                                ),
                                            minHeight: 10,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${attendance.totalPresent + attendance.totalLate} dari ${attendance.totalDayWork} hari',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
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
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Default empty state
        return const Scaffold(body: Center(child: Text('No data')));
      },
    );
  }
}
