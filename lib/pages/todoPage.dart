import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/widgets/todo/todoFAB.dart';
import 'package:ttooler/widgets/todo/tododisplaycard.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _todos = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButton: TodoFloatingAB(),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                child: Image.asset("assets/images/icon_images/todo_icon.png", fit: BoxFit.cover,)
            ),
            SizedBox(width: 5,),
            Text(
              "Todo",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Column(
            children: [
              TodoCard(title: _todos.items[index].title,
                subtitle: _todos.items[index].subtitle!,
                description: _todos.items[index].description,
                index: index,),
              if(index == _todos.items.length -1 ) Container( height: 100,child: Center(child: Text("The end"))),
            ],
          );
        },
        itemCount: _todos.items.length,
      ),
    );
  }
}


class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue) as double,
      lerpDouble(begin!.top, end!.top, elasticCurveValue) as double,
      lerpDouble(begin!.right, end!.right, elasticCurveValue) as double,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue) as double,
    );
  }
}