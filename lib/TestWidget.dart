

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/HxCalendarView.dart';
import 'package:flutter_demo/HxDefaultRender.dart';

class TestWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return TestState();
  }

}

class TestState extends State{
  HxSingleSelectItemRender itemSelectRender;
  var now = DateTime.now();
  HxCalendarBuilder calendarBuilder = HxCalendarBuilder();

  @override
  void initState() {
    super.initState();
    itemSelectRender = HxSingleSelectItemRender((date){
      print("select=> ${date.year}.${date.month}.${date.day}");
      setState(() {

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
    return HxCalendarView(calendarBuilder,now.year,now.month);
  }

}