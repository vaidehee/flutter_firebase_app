import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/style/image_assets.dart';
import 'package:flutterfirebasetask/style/string_assets.dart';
import 'package:flutterfirebasetask/ui/screens/chat_screen.dart';
import 'package:flutterfirebasetask/ui/screens/login_screen.dart';
import 'package:flutterfirebasetask/ui/screens/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPosition = 0;
  SharedPreferences sharedPreferences;

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
    return Container(
      color: ColorAssets.themeColorLightPeach,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ColorAssets.themeColorLightPeach,
            leading: Container(
              margin: EdgeInsets.only(left: 15.0),
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: ColorAssets.themeColorBlack,
                ),
                onPressed: () {
                  //sign out the user
                  signOut(context);
                },
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: CircleAvatar(
                  backgroundColor: ColorAssets.themeColorBlack,
                  backgroundImage: AssetImage(ImageAssets.dummy_profile1),
                ),
              )
            ],
          ),
          body: getScreen(selectedPosition),
          floatingActionButton: GestureDetector(
            onTap: () {
              Toast.show(StringAssets.underDevelopment, context);
            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: ColorAssets.themeColorPink, width: 1.0),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: ColorAssets.themeColorPeach, blurRadius: 15)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: ColorAssets().bgGradients)),
              child: Icon(
                Icons.add,
                color: ColorAssets.themeColorBlack,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildBottomAppBar(),
        ),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: selectedPosition == 0
                        ? ColorAssets.themeColorBlack
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPosition = 0;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: selectedPosition == 1
                        ? ColorAssets.themeColorBlack
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPosition = 1;
                    });
                  },
                ),
              )
            ],
          ),
        );
  }

  Widget getScreen(int selectedPosition) {
    switch (selectedPosition) {
      case 0:
        return ChatScreen();
      case 1:
        return UserScreen();
    }
  }

  void signOut(BuildContext context) {
    //sign our the user
    sharedPreferences.clear();
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName("/login"));
    });
  }
}
