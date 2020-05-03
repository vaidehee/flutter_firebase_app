import 'package:flutter/material.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/style/image_assets.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorAssets().themeGradients)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(itemBuilder: (BuildContext context,int index)
                  {
                    return _buildCellITems(context);
                  },
                  separatorBuilder: (context,index)=>Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.0,),
                  itemCount: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCellITems(BuildContext context) {
    return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                       Row(
                         children: <Widget>[
                           Container(
                             margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                             height: 40.0,
                             width: 40.0,
                             decoration: BoxDecoration(
                               image: DecorationImage(image: AssetImage(ImageAssets.dummy_profile1),fit: BoxFit.cover),
                               shape: BoxShape.circle,
                               border: Border.all(
                                   color: ColorAssets.themeColorBlack, width: 1.0),
                             ),
                           ),
                           SizedBox(width: 10.0,),
                           Column(
                             children: <Widget>[
                               Text("John Doe",style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.w500),),
                               Container(margin: EdgeInsets.only(top: 5.0,left: 3.0),
                                   child: Text("Sample Text",style: TextStyle(color: Colors.grey,fontSize: 12.0,),)),

                             ],
                           )
                         ],
                       ),
                          Container(
                              height: 30.0
                              ,child: Text("10/4/20 11:20 AM",style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: 10.0),))
                        ],
                      ),
                    ),
                  );
  }
}
