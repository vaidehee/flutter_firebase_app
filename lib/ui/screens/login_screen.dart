import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasetask/common/dialog/alert_messages.dart';
import 'package:flutterfirebasetask/common/dialog/alertdialogue.dart';
import 'package:flutterfirebasetask/global/constants.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/style/string_assets.dart';
import 'package:flutterfirebasetask/models/user_data.dart';
import 'package:flutterfirebasetask/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocus, passwordFocus;
  SharedPreferences sharedPreferences;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore fireStore = Firestore.instance;
  bool isProgressVisible = false;
  UserData userData;
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPreferences) {
      setState(() {
        this.sharedPreferences = sharedPreferences;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorAssets.themeColorLightPeach,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ColorAssets().themeGradients)),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildLogoPart(),
                      buildUserInput(context),
                      _buildForgotPassword(context),
                    ],
                  ),
                ),
              ),
              _buildSignup(context),
              _buildLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: isProgressVisible,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
            );
  }

  Widget _buildSignup(BuildContext context) {
    return Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Toast.show(StringAssets.underDevelopment, context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            StringAssets.notRegistered,
                            style: TextStyle(
                                color: ColorAssets.themeColorBlack,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              StringAssets.signUp,
                              style: TextStyle(
                                  color: ColorAssets.themeColorWhite,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )),
                ));
  }

  Widget _buildForgotPassword(BuildContext context) {
    return GestureDetector(
                      onTap: () {
                        Toast.show(StringAssets.underDevelopment, context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text(
                            StringAssets.forgotPassword,
                            style: TextStyle(
                                color: ColorAssets.themeColorBlack,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          )),
                    );
  }

  Widget buildUserInput(BuildContext context) {
    return Stack(
                      children: <Widget>[
                         Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 50.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      ColorAssets.themeColorBlack.withOpacity(0.2),
                                      blurRadius: 15.0,
                                      offset: Offset(5, 10))
                                ],
                              ),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0)),
                                      color: ColorAssets.themeColorWhite),
                                  child: Container(
                                    height: 250.0,
                                    padding: EdgeInsets.only(
                                      bottom: 50.0,
                                      top: 15.0,
                                      left: 35.0,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              StringAssets.login,
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: ColorAssets.themeColorBlack,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                        Container(
                                          height: width / 9,
                                          margin: EdgeInsets.only(top: 25),
                                          child: TextFormField(
                                            controller: _emailController,
                                            focusNode: emailFocus,
                                            textInputAction: TextInputAction.next,
                                            cursorColor: Colors.grey,
                                            keyboardType: TextInputType.emailAddress,
                                            onFieldSubmitted: (term) {
                                              emailFocus.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(passwordFocus);
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText: StringAssets.emailHint,
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Colors.grey)),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ))),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 25,
                                          ),
                                          width: width,
                                          height: width / 9,
                                          child: TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            textInputAction: TextInputAction.done,
                                            cursorColor: Colors.grey,
                                            focusNode: passwordFocus,
                                            onFieldSubmitted: (term) {
                                              passwordFocus.unfocus();
                                            },
                                            decoration: InputDecoration(
                                                hintText: StringAssets.passwordHint,
                                                isDense: true,
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Colors.grey)),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ))),
                                          ),
                                        ),
                                      ],
                                    ),

                                  )),
                            ),
                            Container(height: 25.0,)
                          ],
                        ),
                        Column(children: <Widget>[
                          Container(height: 225.0),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 50.0),
                            child: RaisedButton(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 40.0),
                              color: ColorAssets.themeColorBlack,
                              onPressed: () {
                                if (isLoginFieldsValid()) {
                                  setState(() {
                                    isProgressVisible = true;
                                  });
                                  _navigateToHome(context);
                                }
                              },
                              child: Text(
                                StringAssets.login.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: ColorAssets.themeColorWhite),
                              ),
                            ),
                          )
                        ])
                      ],
                    );
  }

  Widget _buildLogoPart() {
    return Container(
                        margin: EdgeInsets.symmetric(vertical: width / 6.5),
                        child: Text(
                          StringAssets.logo,
                          style: TextStyle(
                              color: ColorAssets.themeColorBlack,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w700),
                        ));
  }

  void _navigateToHome(BuildContext context) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((success) {
      fireStore
          .collection("users")
          .document(success.user.uid)
          .get()
          .then((value) {
        setState(() {
          isProgressVisible = false;
        });
        userData = UserData.data(value.data);
        saveToPrefs(success.user.uid, userData).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              ModalRoute.withName("/homescreen"));
          setState(() {
            isProgressVisible = false;
          });
        });
      });
    }).catchError((error) {
      setState(() {
        isProgressVisible = false;
      });
      if (error is PlatformException) {
        if (error.code == "ERROR_USER_NOT_FOUND") {
          //user is not available->signUp user
          createUser();
        } else if (error.code == "ERROR_WRONG_PASSWORD") {
          AlertDialogClass.alertDialog(
              context: context, msg: StringAssets.invalidPassword);
        }
      }
    });
  }

  Future saveToPrefs(String uid, UserData userData) async {
    sharedPreferences.setBool(Constants.IS_USER_LOGGEDIN, true);
    sharedPreferences.setString(Constants.userId, uid);
    sharedPreferences.setString(Constants.userData, userData.email);
  }

  Future createUser() async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((success) {
      try {
        fireStore.collection("users").document(success.user.uid).setData({
          "email": _emailController.text.trim(),
          "created_date": DateTime.now().millisecondsSinceEpoch,
          "modified_date": DateTime.now().millisecondsSinceEpoch,
        }).catchError((error) {
          setState(() {
            isProgressVisible = false;
          });

          AlertDialogClass.alertDialog(context: context, msg: error);
        }).then((value) {
          setState(() {
            isProgressVisible = false;
          });

          saveToPrefs(success.user.uid, UserData(_emailController.text));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              ModalRoute.withName("/homescreen"));
        });
      } catch (e) {
        print("Failure");
        print("Exception" + e.toString());
      }
    }).catchError((error) {
      setState(() {
        isProgressVisible = false;
      });
      if (error is PlatformException) {
        if (error.code == "ERROR_EMAIL_ALREADY_IN_USE") {
          AlertDialogClass.alertDialog(
              context: context, msg: StringAssets.emailAlreadyInUse);
        }
      }
    });
  }

  bool isLoginFieldsValid() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (email.isEmpty) {
      AlertMessages().showAlert(StringAssets.emptyEmail, scaffoldKey);
      return false;
    } else if (!regExp.hasMatch(email)) {
      AlertMessages().showAlert(StringAssets.invalidEmail, scaffoldKey);
      return false;
    } else if (password.isEmpty) {
      AlertMessages().showAlert(StringAssets.emptyPassword, scaffoldKey);
      return false;
    } else if (password.length < 6) {
      AlertMessages().showAlert(StringAssets.passwordLength, scaffoldKey);
      return false;
    } else {
      return true;
    }
  }
}
