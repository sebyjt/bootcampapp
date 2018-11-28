import 'package:flutter/material.dart';
import 'Selection.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget
{
  @override
  LoginScreen createState()=>new LoginScreen();
}
class LoginScreen extends State<Login>
{
 static TextEditingController controller=new TextEditingController();



  Future submit() async{
    Map data={"Idno":controller.text};
    print(data);
    String url="https://9nfmj2dq1f.execute-api.ap-south-1.amazonaws.com/Development/login";
    String jsonString=json.encode(data);
  await apiRequest(url,jsonString);}
  GlobalKey<ScaffoldState> scaffoldState=new GlobalKey();
  Future<Null> apiRequest(String url,String data) async {
    print("entered api");
    var response = await http.post(
        url,
        headers: { "Content-Type": "application/json"},
        body: data,
        encoding: Encoding.getByName("utf-8")
    );
    Future<Null> storeId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", controller.text);
    }
    print(response.body);
    Map Response=json.decode(response.body);
    if(Response["statusCode"]==200)
      {
        storeId();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Selection()));

      }
      else
        {
          final snackBar = SnackBar(content: Text('invalid credentials'));
          scaffoldState.currentState.showSnackBar(snackBar);
        }

    }
 void _login()
 {
   if(controller.text.isNotEmpty)
   {
     submit();
   }
   else {
     final snackBar = SnackBar(content: Text('please enter your admission number'));
     scaffoldState.currentState.showSnackBar(snackBar);
   }

 }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: scaffoldState,
      body:
          new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image:new AssetImage("Assets/Login2.png"),
                  fit: BoxFit.cover)
          ),
              child:

                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(

                        alignment: Alignment.center,


                        child: Text("Login",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold
                          ),),),
                      new Stack(children: <Widget>[ Container(
                        margin: EdgeInsets.only(bottom:100.0,right:70.0),
                        height: 80.0,
                        decoration: new BoxDecoration(
                            boxShadow:[ new BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.blueGrey
                            )],
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                bottomRight:Radius.circular(50.0),
                                topRight:Radius.circular(50.0)

                            )
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Image.asset("Assets/studenticon.png",
                                height: 25.0,
                                width: 25.0,
                                fit: BoxFit.scaleDown),
                            new Container(
                                width: 200.0,
                                child: TextField(
                                  controller: controller,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Admission Number",

                                  ),
                                )),





                          ],
                        ),
                      ),
                      new Positioned(child: new FlatButton(onPressed: _login, child:  Image.asset("Assets/arrow.png",
                   fit: BoxFit.cover,)),
                            right: 30.0,
                        top: 8.0,
                      )
                    ],



    )])));
  }}