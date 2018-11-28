import 'package:flutter/material.dart';
import 'package:bootcampapp/MakeOrder.dart';
import 'package:bootcampapp/ViewOrder.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Selection extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new   AssetImage("Assets/Login2.png"),
                fit: BoxFit.cover)),
              child: new Center(child: Column(

                  children: <Widget>[

                 new Container(
                   height:50.0,
                   width: 300.0,
                   margin:EdgeInsets.only(left: 10.0,right: 10.0),
                     child:RaisedButton(
                     onPressed: ()=>
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeOrder())),

              child:Text("Make An Order",
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0
                )),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                     color: Colors.green,
          )),
                 new Container(
                     height:50.0,
                     width: 300.0,
                     margin:EdgeInsets.only(top: 20.0),
                     child:RaisedButton(
                       onPressed: ()=>
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewOrder())),

                       child:Text("View Orders",
                           style: new TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.bold,
                               fontSize: 25.0
                           )),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                       color: Colors.green,
                     )),

                  ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,

              ),))



    );
  }
  
}