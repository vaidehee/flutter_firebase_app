import 'package:flutter/material.dart';

class AlertDialogClass{
  static void alertDialog({
  String msg,
  BuildContext context,
}){
    var alert=AlertDialog(
       title: Text("Alert"),
       content: Text(msg,style: TextStyle(fontSize: 17),),
       actions: <Widget>[
         FlatButton(
           child: Text("ok",style: TextStyle(color: Colors.black,fontSize: 17.0),),
           onPressed: (){
             Navigator.pop(context);
           },
         )
       ],
     );
    showDialog(context: context,
    builder: (_){
      return alert;
    });
  }
}