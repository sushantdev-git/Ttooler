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
                subtitle: _todos.items[index].subtitle ,
                description: _todos.items[index].description,
                priority: _todos.items[index].priority,
                heroKey: _todos.items[index].key,
                todoKey: _todos.items[index].key,
                index: index,),
              if(index == _todos.items.length -1 ) Container( height: 100,),
            ],
          );
        },
        itemCount: _todos.items.length,
      ),
    );
  }
}


