import 'package:dockflow_app/core/storage/authstorage.dart';
import 'package:dockflow_app/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dockflow_app/features/auth/view/login.dart';
import 'package:dockflow_app/features/inventory/inventory.dart';
import 'package:dockflow_app/features/mainpage/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final String? token = await AuthStorage.readToken();
  FlutterNativeSplash.remove();

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAFAFC)),
        home: (token != null && token!.isNotEmpty)
            ? const MainPage()
            : const LoginPage(),
        routes: {
          '/loginpage': (context) => LoginPage(),
          '/mainpage': (context) => MainPage(),
          '/inventorypage': (context) => InventoryPage(),
        },
      ),
    );
  }
}
