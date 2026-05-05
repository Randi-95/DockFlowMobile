import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
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
                  margin: EdgeInsets.fromLTRB(15, 160, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo Randi Permana👋🏻",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Semangat bekerja hari ini!",
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
                  margin: EdgeInsets.fromLTRB(8, 210, 8, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color(0XFFF9FBFE),
                      elevation: 0.2,
                      child: Container(
                        margin: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                          "Pemesanan hanya melalui kru",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFF002366),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 170,
                                          child: Text(
                                            "Untuk menjaga akurasi operasional dan kebutuhan konsultasi teknis, pemesanan barang tidak dapat dilakukan oleh pihak kapal (klien).",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey[800],
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

            Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: Color(0XFFF5F8FE),
                      elevation: 0.1,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.blue,
                                  child: Container(
                                    margin: EdgeInsets.all(6),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.inventory_2_sharp,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stok Tersedia",
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
                                      "1.254",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0XFF002366),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "Item",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lihat Inventory",
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
                  Expanded(
                    child: Card(
                      color: Color(0XFFF2FBF7),
                      elevation: 0.1,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Color(0XFF378780),
                                  child: Container(
                                    margin: EdgeInsets.all(6),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.inventory_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pesanan Aktif",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFF378780),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "1.254",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0XFF002366),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "Pesanan",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lihat Detail",
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

            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                color: Color(0XFF013367),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),

                            color: Color(0XFF013367),
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: Card(
                                color: Color(0XFF013367),
                                elevation: 0,
                                child: Icon(
                                  Icons.inventory,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stok Gudang Real-time",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(
                                width: 180,
                                child: Expanded(
                                  child: Text(
                                    "Data stok selalu diperbarui secara real-time pastikan informasi akurat sebelum booking",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                    ),
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
                          side: BorderSide(color: Colors.white, width: 1),
                        ),

                        color: Color.fromARGB(255, 0, 43, 88),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 5,
                                color: const Color.fromARGB(255, 93, 250, 99),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Real-time",
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

            Container(
              margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: Card(
                color: Color(0XFFF9FBFE),
                elevation: 0.3,
                shadowColor: const Color.fromARGB(255, 220, 218, 218),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 12, 3, 12),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  size: 14,
                                  color: Color(0XFF013367),
                                ),

                                SizedBox(width: 8),

                                Text(
                                  "Performa Kehadiran - 1 Bulan Terakhir",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0XFF013367),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lihat Detail",
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
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.8,
                        children: [
                          Card(
                            color: Color(0XFFF3FBF7),
                            elevation: 0.1,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  Text(
                                    "22",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF013367),
                                    ),
                                  ),
                                  Text(
                                    "Hadir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            color: Color(0XFFFDF9F1),
                            elevation: 0.1,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.yellow[800],
                                  ),
                                  Text(
                                    "22",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF013367),
                                    ),
                                  ),
                                  Text(
                                    "Hadir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            color: Color(0XFFFEF4F2),
                            elevation: 0.1,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cancel, color: Colors.red),
                                  Text(
                                    "22",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF013367),
                                    ),
                                  ),
                                  Text(
                                    "Hadir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            color: Color(0XFFF3F8FE),
                            elevation: 0.1,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.groups_rounded,
                                    color: Colors.blue[800],
                                  ),
                                  Text(
                                    "22",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF013367),
                                    ),
                                  ),
                                  Text(
                                    "Hadir",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tingkat Kehadiran",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
                                ),

                                Text(
                                  "92%",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0XFF003998),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 20),

                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: 0.92, // Nilai 92%
                                      backgroundColor: Colors.grey[200],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue[700]!,
                                      ),
                                      minHeight: 10,
                                    ),
                                  ),

                                  SizedBox(height: 4),
                                  Text(
                                    "24 dari 26 hari",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
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
}
