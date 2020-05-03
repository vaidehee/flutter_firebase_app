import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/style/image_assets.dart';
import 'package:flutterfirebasetask/models/user_data.dart';
import 'package:flutterfirebasetask/ui/list_items/item_user_info.dart';

class ItemUserPage extends StatefulWidget {
  final List<UserData> userList;
  ItemUserPage({Key key,this.userList}): super(key: key);
  @override
  _ItemUserPageState createState() => _ItemUserPageState();
}

class _ItemUserPageState extends State<ItemUserPage> {

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.transparent,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
     // width: 200.0,
      child: widget.userList.length==1?Center(
        child:  ItemUserInfo(userName: widget.userList[0].email,),
      ):
      widget.userList.length==2?Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ItemUserInfo(userName: widget.userList[0].email,),
                    SizedBox(width: 30.0,),
                    ItemUserInfo(userName: widget.userList[1].email,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ):
      widget.userList.length==3?Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
                child: ItemUserInfo(shouldAlignBottom: true,userName: widget.userList[0].email,))),
            Expanded(
              child: Container(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ItemUserInfo(userName: widget.userList[1].email,),
                      SizedBox(width: 30.0,),
                      ItemUserInfo(userName: widget.userList[2].email,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,)
          ],
        ),
      )


     : Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ItemUserInfo(shouldAlignBottom: true,userName: widget.userList[0].email),
                        SizedBox(width: 30.0,),
                        ItemUserInfo(shouldAlignBottom: true,userName: widget.userList[1].email),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ItemUserInfo(userName: widget.userList[2].email),
                        SizedBox(width: 30.0,),
                        ItemUserInfo(userName: widget.userList[3].email),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,)
            ],
          ),
        ),
      )
    );
  }
}
