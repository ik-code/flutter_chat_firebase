import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  const AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    var _userEmail = '';
    var _userName = '';
    var _userPassword = '';
    File? _userImageFile;

    void _pickedImage(File image) {
      _userImageFile = image;
    }

    void _trySubmit() {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (_userImageFile == null && !_isLogin) {
        ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(
              content: const Text('Please pick an image.'),
              backgroundColor: Theme.of(context).errorColor,));
        return;
      }

      if (isValid) {
        _formKey.currentState!.save();
        widget.submitFn(_userEmail.trim(), _userPassword.trim(),
            _userName.trim(), _isLogin, context);

        //use those values to send our auth request ...

      }
    }

    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)  UserImagePicker(imagePickFn: _pickedImage,),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email adress',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });

                        print(_isLogin);
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
