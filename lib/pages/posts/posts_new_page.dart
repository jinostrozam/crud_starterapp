import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostNewPage extends StatefulWidget {
  @override
  _PostNewPage createState() => _PostNewPage();
}

class _PostNewPage extends State<PostNewPage> {
  final GlobalKey<FormState> _postNewFormKey = GlobalKey<FormState>();
  final titleInputController = TextEditingController();
  final contentInputController = TextEditingController();

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostsNew Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
              key: _postNewFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Title*', hintText: "Title"),
                    controller: titleInputController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a title.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Content', hintText: "Post content here..."),
                    controller: contentInputController,
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: _isSubmitting
                          ? Center(child: CircularProgressIndicator())
                          : RaisedButton(
                              child: Text('Save Post'),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_postNewFormKey.currentState.validate()) {
                                  try {
                                    setState(() {
                                      _isSubmitting = true;
                                    });
                                    final user = Provider.of<User>(context,
                                        listen: false);
                                    // var user =
                                    // FirebaseAuth.instance.currentUser;
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .collection("posts")
                                        .doc()
                                        .set({
                                      'title': titleInputController.text,
                                      'content': contentInputController.text,
                                      'createdAt': FieldValue.serverTimestamp(),
                                      'updatedAt': FieldValue.serverTimestamp()
                                    });
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/',
                                            (Route<dynamic> route) => false);
                                  } catch (e) {
                                    print('Error Happened!!!: $e');
                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                  }
                                }
                              }))
                ],
              )),
        ),
      ),
    );
  }
}
