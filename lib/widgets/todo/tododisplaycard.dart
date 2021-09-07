import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/todo/todoinputcard.dart';
import 'package:ttooler/konstant/konstant.dart';

import '../popUpCard.dart';

class TodoCard extends StatelessWidget {

  final String title;
  final String description;
  final int index;
  final int priority;
  final String? todoKey;
  final bool isCompleted;
  final TypeCategory category;

  TodoCard({required this.title, required this.description, required this.index, required this.priority, required this.todoKey, required this.isCompleted, required this.category});

  @override
  Widget build(BuildContext context) {
    final _todo = Provider.of<TodoProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        color:  Color(0xff262A3D),
        image: DecorationImage(
          image: AssetImage(getTypeCategoryAddress(category)),
          fit: BoxFit.cover,
          alignment: Alignment.topRight,
          colorFilter: ColorFilter.mode(Color(0xff262A3D).withOpacity(0.8), BlendMode.darken),
        ) ,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ]
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        //This will remove the highlight color from expansion tile.
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10),
          childrenPadding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Row(
            children: [
              Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                  decoration: isCompleted ? TextDecoration.lineThrough: TextDecoration.none,
                  // color: Colors.white70
              ),),
              SizedBox(width: 10,),
              if(isCompleted) Icon(Icons.task_alt, color: Colors.white,)
            ],
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, softWrap: true, style: TextStyle(
              // color: Colors.white70
            ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(icon: isCompleted ? Icons.remove_done:Icons.check, onPress: (){
                  _todo.markCompleted(todoKey!);
                },),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.edit, onPress: (){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return AddTodoPopupCard( cardTitle: "Edit", title: title, description: description, priority: priority.toDouble(), todoKey:todoKey, isCompleted:isCompleted, category: category,);
                  },));
                },),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.delete, onPress: (){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return PopUpCard(
                        title: "Delete Todo",
                        subtitle: "Do you want to delete Todo?",
                        content: "$title",
                        icon: Icons.delete,
                        onPress: (){
                          final _todo= Provider.of<TodoProvider>(context, listen: false);
                          _todo.deleteTodo(key:todoKey!);
                        });
                  },));
                },),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
