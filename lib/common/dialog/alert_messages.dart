import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';


class AlertMessages
{
  Function onclick;
  AlertMessages({this.onclick});
  void showAlert(String msg,GlobalKey<ScaffoldState> scaffoldKey)
  {
    final snackBar = SnackBar(
      duration: Duration(
          seconds: 2
      ),
      content: Text(msg,),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void showDialogAlert(BuildContext context,String msg,{FocusNode focusField}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              actions: <Widget>[
                GestureDetector(
                  onTap: (
                  onclick()
                  ),
                )
              ],

          );
        });
  }

}

