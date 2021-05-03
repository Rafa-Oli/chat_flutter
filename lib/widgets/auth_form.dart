import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //fecha o teclado e submete

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup) UserImagePicker(),
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      decoration: InputDecoration(labelText: "Name"),
                      initialValue: _authData.name,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Name must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(labelText: "E-mail"),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Provide a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Name must be at least 7 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    child: Text(_authData.isLogin ? 'Login' : 'Sign Up'),
                    onPressed: _submit,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                    child: Text(_authData.isLogin
                        ? "Create a new account?"
                        : "Already have an account?"),
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
