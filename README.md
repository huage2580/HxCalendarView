# HxCalendarView

自由定制的日历view，提供简易扩展接口，轻松实现想要的样式    
Freely customizable calendar view with easy extension interface for easy implementation of the desired style  

<p align="center">
	<img src="https://github.com/huage2580/HxCalendarView/blob/master/img/device-2019-08-07-113125.png" alt="Sample"  width="300" >
	<p align="center">
		<em>示例</em>
	</p>
</p>
<p align="center">
	<img src="https://github.com/huage2580/HxCalendarView/blob/master/img/gif_0807.gif" alt="Sample"  width="300" >
	<p align="center">
		<em>use in pageView</em>
	</p>
</p>

## Getting Started
复制 `HxCalendarView.dart` ,`HxDefaultRender.dart`到你的项目  
copy `HxCalendarView.dart` ,`HxDefaultRender.dart` to your project
参考 TestWidget  
simple use ,like TestWidget 
```dart
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
```

## 主要的日历视图 属性  (attribute
```dart
 //show top header like [sun ,mon,tue,wed...]
  bool showHeader = false;

  // the first day show : [sunday or monday]
  bool startWithMonday = false;

  // etc :  28 29 30 1 2 3 4 [or] x x x 1 2 3 4
  bool showOverDay = false;

  // = width / height
  num itemAspectRatio = 1.0;
```
## 在pageView中使用  (use in PageView
参考 : PageViewTest.dart
```dart
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
```
## 自定义  (how to custom your style
默认视图样式在`HxDefaultRender.dart`  
标题渲染(header render):`calendarBuilder.headerRender = HxDefaultHeaderRender();`  
日历渲染(the days item): `calendarBuilder.addItemRender(HxDefaultItemRender());`  
参考实现  
```dart
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
```
标题:  
```dart
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
```

