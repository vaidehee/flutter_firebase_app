import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterfirebasetask/style/color_assets.dart';
import 'package:flutterfirebasetask/models/user_data.dart';
import 'package:flutterfirebasetask/ui/list_items/item_user_page.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Firestore _fireStore = Firestore.instance;
  List<UserData> userList = new List<UserData>();
  List<List<UserData>> subUserList=new List();

  void initState() {
    super.initState();
    //get users from firebase
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero,(){
    });
  
    return Scaffold(
      body:Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorAssets().themeGradients)),
        child:subUserList.length<=0?Center(child:  CircularProgressIndicator(
          backgroundColor: Colors.grey,
        )):
        _buildPageView(context)
      )
    );

  }

  Widget _buildPageView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:50.0,top:15.0,left: 30.0,right: 30.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              width: MediaQuery.of(context).size.width,
              child:ItemUserPage(userList: subUserList[index],));
        },
        autoplay: false,
        itemCount: subUserList.length,
          loop: false,
        scrollDirection: Axis.horizontal,
        pagination: SwiperPagination(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: ColorAssets.themeColorDarkPink,
                size: 10.0,
                activeSize: 10.0)
        )

      ),
    );
  }


  Future<List<UserData>> getUsers() async {

    _fireStore.collection("users").orderBy("created_date",descending: true).snapshots().listen((dataSnapshot) {
      subUserList.clear();
      userList.clear();
      for (int i = 0; i < dataSnapshot.documents.length; i++) {
        userList.add(UserData.data(dataSnapshot.documents[i].data));
      }

      print("Main userList ${userList.length}");

      if(userList.length>0)
      {
        List<UserData> tempList=List();
        for(int i=0;i<userList.length;i++)
        {
          tempList.add(userList[i]);
          if(tempList.length==4)
          {
            List<UserData> list=List();
            for(int j=0;j<tempList.length;j++)
              {
                list.add(tempList[j]);
              }
            subUserList.add(list);
            tempList.clear();
              }

          if(i==userList.length-1)
          {
            if(tempList.length>0)
            {
              subUserList.add(tempList);
               }
          }

        }
      }
      setState(() {
      });
    });
  }
}
