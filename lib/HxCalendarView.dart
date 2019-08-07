import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HxCalendarView extends StatelessWidget {
  final HxCalendarBuilder _builder;
  final int year;
  final int month;

  HxCalendarView(this._builder, this.year, this.month);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_builder.showHeader) _buildHeader(),
          _buildItems()
        ],
      );

  }

  Widget _buildHeader() {
    var weekDays = [
      DateTime.sunday,
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday
    ];
    if (_builder.startWithMonday) {
      weekDays = [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday,
        DateTime.friday,
        DateTime.saturday,
        DateTime.sunday
      ];
    }
    return Row(children: weekDays.map((weekday) {
      return Expanded(flex: 1,child: _builder._headerRender.getHeader(weekday),);
    }).toList());
  }

  Widget _buildItems() {
    final firstDay = DateTime(year, month, 1);
    var weekDay = firstDay.weekday; //从周一开始计算的 意味着要跳过多少格
    if (_builder.startWithMonday) {
      weekDay = weekDay - 1;
    }
    weekDay = weekDay % 7;
    var nowFirstDay = firstDay.subtract(Duration(days: weekDay));
    List<DateTime> items = List.generate(5 * 7, (i) {
      return nowFirstDay.add(Duration(days: i));
    });

    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 7,
      childAspectRatio: _builder.itemAspectRatio,
      children:items.map((value){
        return Stack(children:_renderDays(value,value.month != month));
      }).toList(),
    );
  }

  List<Widget> _renderDays(DateTime day,bool isOver){
    if(!_builder.showOverDay && isOver){
      return [];
    }else{
      List<Widget> items = [];
      for(var render in _builder._itemRender){
        items.add(render.getItem(day, isOver));
      }
      return items;
    }
  }



}


class HxCalendarBuilder {
  //show top header like [sun ,mon,tue,wed...]
  bool showHeader = false;

  // the first day show : [sunday or monday]
  bool startWithMonday = false;

  // etc :  28 29 30 1 2 3 4 [or] x x x 1 2 3 4
  bool showOverDay = false;

  // = width / height
  num itemAspectRatio = 1.0;
  List<HxCalendarItemRender> _itemRender = [];
  HxCalendarHeaderRender _headerRender;

  HxCalendarBuilder addItemRender(HxCalendarItemRender render) {
    _itemRender.add(render);
    return this;
  }

  set headerRender(HxCalendarHeaderRender value) {
    _headerRender = value;
  }
}

abstract class HxCalendarItemRender {
  Widget getItem(DateTime date,bool isOver);

  bool isToday(DateTime time){
    var today = DateTime.now();
    return time.year == today.year && time.month == today.month && time.day == today.day;
  }

  bool isSundayOrSaturday(DateTime time){
    return time.weekday == DateTime.sunday || time.weekday == DateTime.saturday;
  }

  bool equalDay(DateTime time,DateTime other){
    return time!=null && other!=null && time.year == other.year && time.month == other.month && time.day == other.day;
  }
}

abstract class HxCalendarHeaderRender {
  Widget getHeader(int weekday);
}
