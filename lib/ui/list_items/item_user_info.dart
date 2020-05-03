import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/style/image_assets.dart';
import 'package:flutterfirebasetask/style/string_assets.dart';

class ItemUserInfo extends StatelessWidget {
  final bool shouldAlignBottom;
  final String userName;
  ItemUserInfo({Key key,this.shouldAlignBottom,this.userName}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment:shouldAlignBottom!=null && shouldAlignBottom?MainAxisAlignment.end:MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Container(
              height: 65.0,
              width: 65.0,
              child: CircleAvatar(
                backgroundColor: ColorAssets.themeColorBlack,
                backgroundImage: AssetImage(ImageAssets.dummy_profile1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.0),
              child: Text(userName!=null?getName(userName):StringAssets.noUserName,style: TextStyle(color: ColorAssets.themeColorBlack,fontWeight: FontWeight.w500,fontSize: 15.0),))
        ],
      ),
    );
  }
  String getName(String name)
  {
    //as there is no sign up screen, we are getting temporary names from user email --> text before @
    String s = name;
    String userName = s.substring(0, s.indexOf('@'));
    return userName;
  }
}

