import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dockflow_app/features/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

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
                              "Email",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF002366),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outlined),
                                hint: Text(
                                  "Masukkan Email",
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
                              obscureText: _obscureText,
                              controller: passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
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
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthSucces) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.succesMessage),
                                      ),
                                    );

                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/mainpage');
                                  } else if (state is AuthError) {
                                    ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.danger,
                                        title: "Login Failed",
                                        text: state.errorMessage,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Container(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return ElevatedButton(
                                    onPressed: () {
                                      final email = emailController.text.trim();
                                      final password = passwordController.text.trim();
                                      context.read<AuthBloc>().add(
                                        LoginEvent(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF003998),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10),
                                      ),
                                    ),
                                  );
                                },
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
