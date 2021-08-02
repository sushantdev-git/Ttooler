import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/home/glances/todoGlance.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingAB(),
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => TodoGlance(),
        itemCount: 1,
      ),
    );
  }
}

class CustomFloatingAB extends StatelessWidget {
  const CustomFloatingAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: GestureDetector(
      onTap: (){
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return const _AddTodoPopupCard();
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

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: "TodoButton",
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin as Rect , end: end as Rect);
            },
            child: Material(
              color: Theme.of(context).accentColor,
              elevation: 4,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enter Todo", style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff262A3D),
                          // fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xff262A3D),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: const TextField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Title",
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xff262A3D),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: const TextField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Subtitle",
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xff262A3D),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Description"
                            ),
                            cursorColor: Colors.white,
                            maxLines: null,

                          ),
                        ),
                        SizedBox(height: 20,),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: (){}, child: Text("Choose category")),
                              SizedBox(width: 30,),
                              ElevatedButton(onPressed: (){}, child: Text("Ok")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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