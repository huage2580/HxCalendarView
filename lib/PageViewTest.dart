import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'HxCalendarView.dart';
import 'HxDefaultRender.dart';


void main() {
  runApp(Test());
}

class Test extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return TState();
  }

}

class TState extends State<Test>{
  var controller = PageController(initialPage: 55555);
  HxSingleSelectItemRender itemSelectRender;
  var now = DateTime.now();
  HxCalendarBuilder calendarBuilder = HxCalendarBuilder();

  var title = "";

  @override
  void initState() {
    super.initState();
    title = "${now.year}-${now.month}";
    itemSelectRender = HxSingleSelectItemRender((date){
      setState(() {
        itemSelectRender.selectDay = date;
      });
    });
    calendarBuilder.itemAspectRatio = 3/2;
    calendarBuilder.showHeader = true;
    calendarBuilder.showOverDay = true;
    calendarBuilder.headerRender = HxDefaultHeaderRender();
    calendarBuilder.addItemRender(itemSelectRender);
    calendarBuilder.addItemRender(HxDefaultItemRender());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
           child:Column(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               // a stupid way ,but .. useful
               AspectRatio(
                 aspectRatio: 7/6 * calendarBuilder.itemAspectRatio, //row 6 & Column 7
                 child: PageView.custom(
                     controller: controller,
                     childrenDelegate: new SliverChildBuilderDelegate(
                           (context, index) {
                         print("create $index");
                         var temp  = DateTime(now.year,now.month-(55555-index));
                         return HxCalendarView(calendarBuilder,temp.year,temp.month);
                       },
                       childCount: 99999,
                     ),
                     onPageChanged: (index){
                       print("create $index");
                       var temp  = DateTime(now.year,now.month-(55555-index));
                       setState(() {
                         title = "${temp.year}-${temp.month}";
                       });
                     },
                   ),
               ),
               Expanded(
                 child: Text("some else widget"),
               )
             ],
           ),

        ),
      ),
    );
  }
}