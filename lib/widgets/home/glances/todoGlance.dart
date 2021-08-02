import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/homePage.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/home/glances/glaceUtility/expanstionCard.dart';

class TodoGlance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final todos = Provider.of<TodoProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 100),
      width: double.infinity,
      child: Column(
        children: [
          GlanceHeader(glanceType: GlanceType.Todo,),
          todos.items.length == 0 ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              TodoCard(),
              SizedBox(height: 15,),
              TodoCard(),
              SizedBox(height: 15,),
              TodoCard(),
              SizedBox(height: 15,),
              TextButton(onPressed: (){
                Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TodoPage(), exitPage: HomePage()));
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
                Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TodoPage(), exitPage: this));
              }, child: Text("Your Todo list seems empty \n add some..", style: TextStyle(
                fontSize: 20,
              ), textAlign: TextAlign.center,),),
            ),
          ),
        ],
      ),
    );
  }
}
