import 'package:flutter/material.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/todo/todopopupcard.dart';

class CustomFloatingAB extends StatelessWidget {
  const CustomFloatingAB({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: GestureDetector(
      onTap: (){
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return AddTodoPopupCard();
        },));
      },
      child: Hero(
        tag: "TodoButton",
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin as Rect, end: end as Rect);
        },
        child: Material(
          elevation: 2,
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: const Icon(
            Icons.add,
            size: 56,
            color: Color(0xff262A3D),
          ),
        ),
      ),
    ),);
  }
}