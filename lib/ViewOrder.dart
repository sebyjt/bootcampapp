import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ViewOrderDetails.dart';
class ViewOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ViewOrderState();
  }
}
class ViewOrderState extends State<ViewOrder>
  {
    Map data;
    String url="https://9nfmj2dq1f.execute-api.ap-south-1.amazonaws.com/Development/orders/get-all";
    Future<Null> getOrders() async{
      data=await apiRequest(url);
      setState(() {

      });

  }
  _viewDetails(Map items)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewOrderDetails(items)));
  }
  Future<Map> apiRequest(url)
    async{
      http.Response response=await http.get(url);
      print(response.body);
      return json.decode(response.body);
    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage("Assets/ViewOrders.png"),fit: BoxFit.fill)
        
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ new Center(child: Padding(padding: EdgeInsets.only(top: 30.0),
          child: new Text("Orders",style: new TextStyle(
            color: Colors.white,
            fontSize: 32.0,
            fontWeight: FontWeight.bold
          ) ,),)),
          new Padding(padding: EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0),child:
              new Center(child:
                  new Container(
                    height: 490.0,
              margin: EdgeInsets.only(bottom: 5.0),
              child:
    (data!=null)?

                 ListView.builder(itemCount:data["Menu_ITEMS"].length,
                  shrinkWrap: true,

                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  itemBuilder: (BuildContext context,int position){
                
                return new GestureDetector( onTap:()=>_viewDetails(data["Menu_ITEMS"][position]),child:Center(child:new Container(height: 60.0,width:300.0,
                    margin:EdgeInsets.only(top: 10.0),child:
                    Card(shape:new RoundedRectangleBorder(borderRadius:
                    new BorderRadius.circular(10.0)),child:
                    new Center(child:    Text(data["Menu_ITEMS"][position]["OrderDate"],style:
                    new TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),)),elevation: 5.0,))));
                }):
    new Center(child:  CircularProgressIndicator(
      valueColor:new  AlwaysStoppedAnimation<Color>(Colors.green),
    ))
    )))]
        ),
      ),
    );
    
  }
    
  
}