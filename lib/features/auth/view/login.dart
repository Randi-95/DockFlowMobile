import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFF002366),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Akses sistem ini hanya untuk kru lapangan PT.DockFlow Maritim Sinergi",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF002366),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "v1.0.0",
                style: TextStyle(fontSize: 11, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
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
                  margin: EdgeInsets.fromLTRB(10, 210, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Card(
                      color: Colors.white,
                      elevation: 0.2,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang Kembali!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF002366),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Login untuk mengakses sistem operasional internal PT.Dockflow Maritim Sinergi",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 22),
                            Text(
                              "ID Karyawan",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF002366),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outlined),
                                hint: Text(
                                  "Masukkan ID Karyawan",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ), // Warna lebih tegas saat fokus
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF002366),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: Icon(Icons.visibility),
                                hint: Text(
                                  "Masukkan Password",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ), // Warna lebih tegas saat fokus
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/mainpage');
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF003998),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
