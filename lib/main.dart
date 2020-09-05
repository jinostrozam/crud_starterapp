import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:starterapp/pages/home_page.dart';
import 'package:starterapp/pages/login_page.dart';
import 'package:starterapp/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(), // remove when using routes
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/sign_up': (context) => RegisterPage(),
      },
    );
  }
}
