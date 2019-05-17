import 'package:flutter/material.dart';

import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soi/utilities/auth.dart';

import 'home.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  Future<bool> _loginWithGoogle() async {
    /*final api = await auth.googleSignIn();
    if (api != null) {
      return true;
    } else {
      return false;
    }*/
  }

  Future<bool> _createUserEmailPassword(String email, String password) async {
    final api = await auth.createUser(email, password);
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextStyle signUpTextStyle = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  TextStyle signUpGoogleTextStyle = new TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );

  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _email, _password;

  bool hidePassword = true;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String validatePassword(String value) {
    // for phone numbers String patttern = r'(^[0-9]*$)';
    //RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password must at least 6 digits";
    }
    /*else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }*/
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Email $_email");

      bool b = await widget._createUserEmailPassword(_email, _password);
      if (b) {
        setState(() {
          widget.onSignIn();
        });
        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong Email!'),
          ),
        );
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: new Image.asset('assets/images/urltv_original.png',
            fit: BoxFit.cover),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: new Image.asset('assets/images/soi_login_bg2.jpg',
                fit: BoxFit.cover),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: formUI(),
            ),
          ),
        ],
      ),
    );
  }

  Widget formUI() {
    final createAccountButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 46.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            _sendToServer();
          },
          color: Colors.black,
          child: Text('CREATE ACCOUNT', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final googleSignUpButton = InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new HomePage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 50,
          width: 200,
          decoration: ShapeDecoration(
              color: Colors.red[800],
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
              )),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: new Text(
                      'OOGLE SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );

    final facebookSignUpButton = InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new HomePage(),
            ),
          );
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: ShapeDecoration(
              color: Colors.indigo,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'FACEBOOK SIGN UP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));

    return new ListView(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Text(
            'Create a SOI account to get started',
            style: signUpTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 35.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: new Text(
              'Email Address',
              style: signUpTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          width: 350.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              maxLength: 40,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onSaved: (String val) {
                _email = val;
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 35.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: new Text(
              'Password',
              style: signUpTextStyle,
            ),
          ),
        ),
        Container(
          width: 350.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new TextFormField(
                obscureText: hidePassword,
                decoration: new InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: validatePassword,
                onSaved: (String val) {
                  _password = val;
                }),
          ),
        ),
        Container(child: Center(child: createAccountButton)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                googleSignUpButton,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                facebookSignUpButton,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
