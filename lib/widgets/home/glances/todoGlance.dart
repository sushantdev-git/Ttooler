import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/homePage.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/todo/tododisplaycard.dart';

class TodoGlance extends StatelessWidget {

  List<Widget> getTodo(List<Todo> todoData, var todo){
    List<Widget> _todo= [];

    for(int i=-1; i<min(todoData.length, 4); i++){
      if(i == -1 ) {
        _todo.add(Text(
          "Completed ${todo.countCompleted()}/${todo.items.length}",
          style: TextStyle(fontSize: 17),
        ),);
        continue;
      }
      _todo.add(TodoCard(title: todoData[i].title,  description: todoData[i].description, index: i, priority: todoData[i].priority, todoKey: todoData[i].id, isCompleted: todoData[i].isCompleted, category: todoData[i].category,));
    }

    return _todo;
  }

  @override
  Widget build(BuildContext context) {
    final _todos = Provider.of<TodoProvider>(context);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 100),
      width: double.infinity,
      child: Column(
        children: [
          GlanceHeader(glanceType: GlanceType.Todo,),
          _todos.items.length != 0 ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              ...getTodo(_todos.items, _todos),
              TextButton(onPressed: (){
                Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TodoPage()));
              }, child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("See all", style: TextStyle(
                    fontSize: 20,
                  ),),
                  SizedBox(width: 10,),
                  Icon(Icons.east, color: Colors.white,)
                ],
              ))
            ],
          ) :
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: Center(
              child: TextButton(onPressed: (){
                Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TodoPage()));
              }, child: Text("Your Todo list seems empty \n add some.. 😒", style: TextStyle(
                fontSize: 20,
              ), textAlign: TextAlign.center,),),
            ),
          ),
        ],
      ),
    );
  }
}
