import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:starterapp/pages/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.isAuthenticated}) : super(key: key);
  final bool isAuthenticated;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: _drawer(context),
      body: Center(
        child: widget.isAuthenticated
            ? Text('HomePage after login')
            : Text('HomePage before login'),
      ),
    );
  }
}

Widget _drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.vpn_key),
          title: Text('Login'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Register'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/sign_up');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () async {
            await FirebaseAuth.instance.signOut();

            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    ),
  );
}
