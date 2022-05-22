import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
      String email, 
      String password, 
      String username, 
      bool isLogin
      ) {

      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm( submitFn: _submitAuthForm,),
    );
  }
}
