import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/pages/posts/posts_new_page.dart';
import 'package:starterapp/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: HomeDrawer(),
      // body: Center(
      //   child: isAuthenticated
      //       ? Text('User logged successfully')
      //       : Text('No user logged in'),
      // ),
      body: (Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isAuthenticated) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PostNewPage()));
          }
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
