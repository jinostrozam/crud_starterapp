import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(
                      document.data()['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(document.data()['content']),
                  );
                }).toList(),
              );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (isAuthenticated) {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => PostNewPage()));
      //     }
      //   },
      //   child: Icon(Icons.note_add),
      // ),
    );
  }
}
