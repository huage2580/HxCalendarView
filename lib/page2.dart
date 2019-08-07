

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/TestWidget.dart';

class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page2"),),
      body: Container(
        child: Column(
          children: <Widget>[
            TestWidget(),
            RaisedButton(
              child: Text("click!"),
              onPressed: (){
              },
            )
          ],
        ),
      )
    );
  }

}
