import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/widgets/buttons/customFAB.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/home/glances/glaceUtility/expanstionCard.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _todos = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButton: CustomFloatingAB(),
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            GlanceHeader(glanceType: GlanceType.Todo),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => TodoCard(title: _todos.items[index].title, subtitle: _todos.items[index].subtitle!, description: _todos.items[index].description),
              itemCount: _todos.items.length,
            ),
          ],
        ),
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