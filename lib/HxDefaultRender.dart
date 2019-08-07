

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/HxCalendarView.dart';

class HxDefaultHeaderRender implements HxCalendarHeaderRender{
  @override
  Widget getHeader(int weekday) {
    return Center(
      child: Text(
          ["一","二","三","四","五","六","日"][weekday-1]
      ),
    );
  }
}


class HxSingleSelectItemRender extends HxCalendarItemRender{

  ValueChanged<DateTime> onItemClick;
  DateTime selectDay = DateTime.now();

  HxSingleSelectItemRender(this.onItemClick);

  @override
  Widget getItem(DateTime date, bool isOver) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          child:  Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 30,
                maxHeight: 30,
              ),
              decoration: equalDay(date, selectDay)?BoxDecoration(
                  color: Colors.amberAccent,
                  shape: BoxShape.circle
              ):null,
            ),
          ),
      ),
      onTap: (){
        selectDay = date;
        onItemClick(date);
      },
    );
  }



}



class HxDefaultItemRender extends HxCalendarItemRender{
  @override
  Widget getItem(DateTime date, bool isOver) {

    return IgnorePointer(
      child:Center(
        child:  Text(
          "${date.day}",
          style: TextStyle(
            color:(isToday(date)?Colors.blue:((isOver?Colors.grey:( isSundayOrSaturday(date)?Colors.redAccent:Colors.black)))),
            fontSize: 18.0,
            height: 1.2,
          ),
        ),
      ) ,
    ) ;
  }

}