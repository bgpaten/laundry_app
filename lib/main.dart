import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laundry_app/screens/customer_order_screen.dart';
import 'package:laundry_app/screens/login_screen.dart';
import 'package:laundry_app/screens/register_screen.dart';
import 'package:laundry_app/screens/home_screen.dart';
import 'package:laundry_app/screens/partner_profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => CustomerHomeScreen(),
        '/order': (context) => CustomerOrderScreen(),
        '/partner_profile': (context) => PartnerProfileScreen(),
      },
    );
  }
}
