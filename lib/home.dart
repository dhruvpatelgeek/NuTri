import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(

                alignment: Alignment(0, 0),
                
      child: Column(
        
        children: <Widget>[
          Container(
            
                  height: 390.0,
                  width: 340.0,
          decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/logo.png")),
                  ),
          ),
Row(children: <Widget>[
 Padding(
  
  padding: EdgeInsets.all(10) ,
),
            Text("We are collecting your \ninfo. Check back in \na week for more \ninformation",

            style: TextStyle(
              fontSize: 30,
              
              
            ),
          ),
],)
          
        ],
      ),
      
    );
  }
}
