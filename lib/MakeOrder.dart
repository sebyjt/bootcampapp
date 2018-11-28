import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MakeOrder extends StatefulWidget
{   MakeOrderState createState()=>new MakeOrderState();}
class MakeOrderState extends State<MakeOrder>

{

  var selected=new DateTime.now();
var formatter = new DateFormat('dd-MMM-yy');
var formatted;
bool noSelected=true;
Map data;
String id;
List newData=[];
GlobalKey<ScaffoldState> scoffoldkey=new GlobalKey();
String url="https://9nfmj2dq1f.execute-api.ap-south-1.amazonaws.com/Development/menu/get-all";
bool checkval=false;
bool checkval2=false;
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    print(id);

  }
  Future<Null> getItems() async{
   data=await apiRequest(url);
   print( data["Menu_ITEMS"].length);

    for(int i=0;i<data["Menu_ITEMS"].length;i++)
      {
        Map temp={
          "ItemName":data["Menu_ITEMS"][i]["ItemName"],
          "ItemPrice":data["Menu_ITEMS"][i]["Price"],
          "Selected":false
        };
        newData.add(temp);
      }
   print(data);
    print(newData);
    setState(() {

    });
  }
  Future _order() async{

    Map orders={};
  Map sendData={
    "IDNo":id,
    "OrderDate":formatted

  };

  for(int i=0;i<newData.length;i++)
    {
      if(newData[i]["Selected"])
        {
          noSelected=false;
          Map temp={newData[i]["ItemName"]:newData[i]["ItemPrice"]};
          orders.addAll(temp);


    }}
    sendData["OrderedItems"]=orders;
  print(sendData);
  String url="https://9nfmj2dq1f.execute-api.ap-south-1.amazonaws.com/Development/orders/add-order";
  String jsonString=json.encode(sendData);
  if(!noSelected)
  await apiRequestPost(url,jsonString);
  else
    {
      var snackbar=new SnackBar(content: Text("Please select an item"));
      scoffoldkey.currentState.showSnackBar(snackbar);
    }
  }
Future<Null> apiRequestPost(String url,String data) async {
  print("entered api");
  var response = await http.post(
      url,
      headers: { "Content-Type": "application/json"},
      body: data,
      encoding: Encoding.getByName("utf-8")
  );

  print(response.body);
  Map Response = json.decode(response.body);
  if (Response["statusCode"] == 200) {
    print("Success");
    Navigator.of(context).pop();
  }
  else {
    print("Failed");
  }
}
  Future<Map> apiRequest(String url)
  async{
    http.Response response=await http.get(url);
    print(response.body);
    return json.decode(response.body);
  }
@override
void initState() {
    getSharedPrefs();
    getItems();


  }
  @override
  Widget build(BuildContext context)
  {

    formatted = formatter.format(selected);
    _showCalendar() async {

     selected = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1960),
        lastDate: new DateTime(2050),

      );

     formatted = formatter.format(selected);
     print("$formatted");
      setState(() {



      });



    }

    final textStyle=new TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
    return new Scaffold(
      key: scoffoldkey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image:new AssetImage( "Assets/Login2.png"),
            fit: BoxFit.cover
          )
        ),
        child:
            new Center(child:
              new Container(
                height: 400.0,
            width: 300.0,
            child:  Card(

                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                child:new Center(child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new GestureDetector(
                  onTap:_showCalendar,
                    child: Container(child: Card(elevation:10.0,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                    child: new Center(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[new Icon(Icons.calendar_today),
                      new Text('$formatted',style: textStyle)
                      ],
                    ))),
                  height: 70.0,
                  width: 300.0,
                  margin: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0),)),
              new Container(child: Card(elevation:10.0,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                  child: new Center(child:
                  (data!=null)?
                      new ListView.builder(
                      itemCount: data["Menu_ITEMS"].length,
                      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                      itemBuilder:(BuildContext context,int position){
                        return  new Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[ new Text(data["Menu_ITEMS"][position]["ItemName"],style: textStyle,
                            ),
                              new Checkbox(value: newData[position]["Selected"], onChanged: (bool value){newData[position]["Selected"]=value;print(newData);
                              setState(() {

                              });})
                        ]);}):
                  new CircularProgressIndicator(
                    valueColor:new  AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                  )),
                height: 150.0,
                width: 300.0,
                margin: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0),),
                new Container(
                    height:50.0,
                    width: 300.0,
                    margin:EdgeInsets.only(top: 20.0,left: 40.0,right: 40.0),
                    child:RaisedButton(
                      onPressed: _order,
                      child:Text("Order",
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          )),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.green,
                    ))

                  ],
                )) ,

              )

        ),
      ))

    );
  }

}


