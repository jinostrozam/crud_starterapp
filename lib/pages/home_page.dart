import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/global_state.dart';
import 'package:starterapp/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.isAuthenticated}) : super(key: key);
  // final bool isAuthenticated;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final bool isAuthenticated = Provider.of<bool>(context);
    // final bool isAuthenticated =
    //     Provider.of<GlobalState>(context).isAuthenticated;
    final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      // drawer: HomeDrawer(isAuthenticated: widget.isAuthenticated),
      drawer: HomeDrawer(),
      body: Center(
        // child: widget.isAuthenticated
        child: isAuthenticated
            ? Text('User logged successfully')
            : Text('No user logged in'),
      ),
    );
  }
}

// Widget _drawer(BuildContext context) {
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         DrawerHeader(
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//           child: Text(
//             'Drawer Header',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//             ),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.vpn_key),
//           title: Text('Login'),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => LoginPage()),
//             );
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.account_circle),
//           title: Text('Register'),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.pushNamed(context, '/sign_up');
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.settings),
//           title: Text('Settings'),
//         ),
//         ListTile(
//           leading: Icon(Icons.exit_to_app),
//           title: Text('Logout'),
//           onTap: () async {
//             await FirebaseAuth.instance.signOut();

//             Navigator.pushNamed(context, '/');
//           },
//         ),
//       ],
//     ),
//   );
// }
