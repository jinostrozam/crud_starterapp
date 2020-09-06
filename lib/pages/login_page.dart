import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/global_state.dart';
import 'package:starterapp/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: RaisedButton(
                    child: Text("Login"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_registerFormKey.currentState.validate()) {
                        _signIn();
                        // print('Validation Ok! Submit!');
                        // print('name: ${_nameController.text}');
                        // print('email: ${_emailController.text}');
                        // print('password: ${_passwordController.text}');
                        // print(
                        //     'confirmPassword: ${_confirmPasswordController.text}');
                      }
                    },
                  ),
                ),
                Text("Aun no tienes cuenta?"),
                FlatButton(
                  child: Text("Registrate aqui"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;

      // Provider.of<GlobalState>(context, listen: false)
      //     .updateIsAuthenticated(true);

      Navigator.pushNamed(context, '/');
    } catch (e) {
      print('Ocurrio un error al ingresar. $e');
    }
  }
}
