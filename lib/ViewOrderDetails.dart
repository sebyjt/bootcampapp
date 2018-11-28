import 'package:flutter/material.dart';
class ViewOrderDetails extends StatelessWidget {
  Map data;

  ViewOrderDetails(this.data);

  List OrderedItems=[];
  double totalPrice=0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   for(var k in data["OrderedItems"].keys)
     {
       Map temp={
         "ItemName":k,
         "ItemPrice":data["OrderedItems"][k]

       };
       totalPrice+=double.parse(data["OrderedItems"][k]);
       OrderedItems.add(temp);
     }

      print(OrderedItems);
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: AssetImage("Assets/ViewOrders.png"), fit: BoxFit.cover)
        ),
        child: new Center(
          child: new Container(
            height: 300.0,
            width: 300.0,
            margin: EdgeInsets.all(20.0),
            child: new Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child:
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(
                    "Admission Number: ${data["IDNo"]}", style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0
                  ),),
                  new Text("Date: ${data["OrderDate"]}", style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0
                  ),),
                  new Text("Order Receipt", style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.green
                  ),),
                  new Container(height: 80.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Card(elevation: 3.0,
                          child: new Center(child: new ListView.builder(
                              itemCount: OrderedItems.length,
                              padding: EdgeInsets.all(5.0),
                              itemBuilder: (BuildContext context,
                                  int position) {
                                return new Container(padding:EdgeInsets.all(5.0),child:  Center(child: Text("${OrderedItems[position]["ItemName"]}*1= ${OrderedItems[position]["ItemPrice"]} Rs",style:
                                  new TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 18.0
                                  ),)));
                                })))),
                  new Text("Total: Rs ${totalPrice}", style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0
                  ),)
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}