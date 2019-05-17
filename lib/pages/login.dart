import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soi/pages/signup.dart';
import 'package:soi/utilities/auth.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  Future<bool> _loginWithGoogle() async {
    try {
      /*final api = await auth.googleSignIn();

      if (api != null) {
        return true;
      } else {
        return false;
      }*/
    } catch (error) {
      print('Error: ' + error.toString());
      return false;
    }
  }

  Future<bool> _loginWithEmailPassword(String email, String password) async {
    final api = await auth.emailPasswordSignIn(email, password);

    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle loginTextStyle = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  TextStyle loginWithGoogleTextStyle = new TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );

  TextStyle forgotPassordTextStyle = new TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );

  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool hidePassword = true;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _email, _password;

  bool acceptedEULA = false;

  Color eulaTextColor = Colors.white;

  /*_LoginPageState() {
    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() {
          _email = _emailController.text;
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          _password = _passwordController.text;
        });
      }
    });
  }*/

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

  _sendToServer(BuildContext context) async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Email $_email");

      bool b = await widget._loginWithEmailPassword(_email, _password);
      b
          ? widget.onSignIn()
          : Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Wrong Email and/or Password!'),
              ),
            );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  bool validEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleLoginButton = InkWell(
      onTap: ()  {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new HomePage(),
              ),
          );
          },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                      'OOGLE LOGIN',
                      style: loginWithGoogleTextStyle,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );

    final facebookLoginButton = InkWell(
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
                'LOGIN WITH FACEBOOK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));

    final signUpButton = InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new SignUpPage(
                  auth: widget.auth,
                  onSignIn: widget.onSignIn,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(children: <Widget>[
          new Icon(
            Icons.person_add,
            color: Colors.white,
            size: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              'SIGN UP',
              style: loginWithGoogleTextStyle,
            ),
          )
        ]),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: null,
      body: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: new Image.asset('assets/images/soi_login_background.jpg',
                    fit: BoxFit.cover),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              new Container(
                margin: new EdgeInsets.all(10.0),
                child: new Form(
                    key: _key,
                    autovalidate: _validate,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: new Text(
                                'Welcome to SOI',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: new Text(
                            'Log in to continue.',
                            style: loginTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 35.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: new Text(
                              'Email Address',
                              style: loginTextStyle,
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                              style: loginTextStyle,
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
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
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5.0),
                                  shadowColor: Colors.lightBlueAccent.shade100,
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    minWidth: 200.0,
                                    height: 42.0,
                                    onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => new HomePage(),
                                            ),
                                        );
                                    },
                                    color: Colors.black,
                                    child: Text('LOG ME IN',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: FlatButton(
                                  onPressed: () async {
                                    if (_emailController.text.length > 0) {
                                      if (validEmail(_emailController.text)) {
                                        await widget.auth
                                            .sendPasswordResetEmail(
                                                _emailController.text);
                                        _showToast(
                                            context,
                                            'Sent password reset email to: ' +
                                                _emailController.text);
                                      } else {
                                        _showToast(
                                            context, 'Invalid Email Format!');
                                      }
                                    } else {
                                      _showToast(context,
                                          'Enter email in Email Address field, and then press Forgot Password.');
                                    }
                                  },
                                  child: new Text(
                                    'FORGOT PASSWORD?',
                                    style: forgotPassordTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                googleLoginButton,
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            facebookLoginButton,
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            signUpButton,
                          ],
                        )
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        /*action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),*/
      ),
    );
  }
}
