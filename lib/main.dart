import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/global_state.dart';
import 'package:starterapp/pages/home_page.dart';
import 'package:starterapp/pages/login_page.dart';
import 'package:starterapp/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool isAuthenticated = false;
  String testProviderText = 'Probando provider';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   FirebaseAuth.instance.authStateChanges().listen((user) {
  //     print('authStateChanged Called');

  //     setState(() {
  //       isAuthenticated = user != null;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<String>(create: (context) => testProviderText),
        // Provider<bool>(create: (context) => isAuthenticated),
        // ChangeNotifierProvider<GlobalState>(create: (context) => GlobalState())
        StreamProvider<User>(
            create: (context) => FirebaseAuth.instance.authStateChanges())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(), // remove when using routes
        initialRoute: '/',
        routes: {
          // '/': (context) => HomePage(isAuthenticated: isAuthenticated),
          '/': (context) => HomePage(),
          '/sign_up': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
