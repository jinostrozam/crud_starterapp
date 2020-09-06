import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starterapp/global_state.dart';
import 'package:starterapp/pages/login_page.dart';
import 'package:starterapp/pages/posts/my_posts_page.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key, this.isAuthenticated}) : super(key: key);
  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    // final bool isAuthenticated = Provider.of<bool>(context);
    // final bool isAuthenticated =
    //     Provider.of<GlobalState>(context).isAuthenticated;
    final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            // child: Text(
            //   '${Provider.of<String>(context)}',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 24,
            //   ),
            // ),
            child: Text(
              '${Provider.of<String>(context)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            // child: Consumer<String>(
            //   builder: (context, value, child) {
            //     return Text(
            //       "$value",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 24,
            //       ),
            //     );
            //   },
            // ),
          ),
          if (!isAuthenticated) ...[
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
          ],
          if (isAuthenticated) ...[
            ListTile(
              leading: Icon(Icons.note),
              title: Text('My Posts'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPostsPage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                // Provider.of<GlobalState>(context, listen: false)
                //     .updateIsAuthenticated(false);

                Navigator.pushNamed(context, '/');
              },
            ),
          ]
        ],
      ),
    );
  }
}
