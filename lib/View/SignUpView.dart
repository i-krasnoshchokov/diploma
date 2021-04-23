import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../Service/ProviderWidget.dart';

import '../Service/AuthService.dart';

enum AuthFormType {
  signIn,
  signUp
}

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  const SignUpView({Key key, this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {

  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  void submit() async {
    final auth = MyProvider.of(context).auth;
    final form = formKey.currentState;
    form.save();
    try{
      if (authFormType == AuthFormType.signIn){
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with $uid");
        Navigator.of(context).pushReplacementNamed('/menu');
      } else {
        String uid = await auth.createUserWithEmailAndPassword(_email,
            _password, _name);
        print("Signed up with $uid");
        Navigator.of(context).pushReplacementNamed('/menu');
      }
    } catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildSignUpInHeader(),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, top: 0.0, right: 22.0, bottom:0),
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Column(
                        children: buildInputs() + buildButtons(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  buildSignUpInHeader() {
    String _headerText;
    if(authFormType == AuthFormType.signUp){
      _headerText = "Create new account";
    } else {
      _headerText = "Sign in";
    }
    return Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 95.0, right: 0.0, bottom:50),
            child: Text(_headerText, style: TextStyle(fontSize: 27,
                fontWeight: FontWeight.w200, color: Colors.black)),
        );
  }

  List<Widget> buildInputs(){
    List<Widget> textFields =[];

    if(authFormType == AuthFormType.signUp){
      textFields.add(
          TextFormField(
            style: TextStyle(fontSize: 27,
                fontWeight: FontWeight.w200, color: Colors.black),
            decoration: buildSignUpInputDecoration("Name"),
            onSaved: (value) => _name = value,
          )
      );
      textFields.add(SizedBox(height: 10));
    }

    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 27,
          fontWeight: FontWeight.w200, color: Colors.black),
        decoration: buildSignUpInputDecoration("E-mail"),
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _email = value,
      )
    );
    textFields.add(SizedBox(height: 10));
    textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 27,
              fontWeight: FontWeight.w200, color: Colors.black),
          decoration: buildSignUpInputDecoration("Password"),
          onSaved: (value) => _password = value,
        )
    );

    return textFields;
  }

  List<Widget> buildButtons(){
    String _authButton;
    if(authFormType == AuthFormType.signUp){
      _authButton = "Create new account";
    } else {
      _authButton = "Sign in";
    }
    return [
      TextButton(
          onPressed: submit,
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 100.0, right: 0.0, bottom:0),
            child: Text(_authButton, style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.w200, color: Colors.black)),
          ))
    ];
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white70,
        focusColor: Colors.white70,
      );
  }
}


