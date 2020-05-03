import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/global/constants.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/ui/screens/home_screen.dart';
import 'package:flutterfirebasetask/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences sharedPreferences;
  bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPreferences) {
      setState(() {
        this.sharedPreferences = sharedPreferences;
        isLoggedIn = sharedPreferences.getBool(Constants.IS_USER_LOGGEDIN);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor appThemeColor = MaterialColor(0XFFFCDFD3, color);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Task',
      theme: ThemeData(
          primarySwatch: appThemeColor,
          primaryColor: ColorAssets.themeColorPeach,
          accentColor: ColorAssets.themeColorPeach,
          cursorColor: ColorAssets.themeColorPeach),
      home:getRedirection(sharedPreferences, isLoggedIn),
    );
  }
  Widget getRedirection(
      //check if user already signed in->if not move to LoginScreen else move to HomeScreen
      SharedPreferences sharedPreferences, bool isLogin) {
    if (sharedPreferences == null) {
      return Container();
    } else {
      if (isLogin != null && isLogin == true) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    }
  }

  Map<int, Color> color = {
    50: Color.fromARGB(1, 255, 255, 255),
    100: Color.fromARGB(1, 255, 255, 255),
    200: Color.fromARGB(-1, 255, 255, 255),
    300: Color.fromARGB(1, 255, 255, 255),
    400: Color.fromARGB(1, 255, 255, 255),
    500: Color.fromARGB(1, 255, 255, 255),
    600: Color.fromARGB(1, 255, 255, 255),
    700: Color.fromARGB(1, 255, 255, 255),
    800: Color.fromARGB(1, 255, 255, 255),
    900: Color.fromARGB(1, 255, 255, 255),
  };
}

