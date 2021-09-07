import 'package:flutter/cupertino.dart';
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
                child: Image.asset(
                  "assets/images/icon_images/todo_icon.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 5,
            ),
            Text(
              "Todo",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: _todos.items.length == 0
          ? Center(
              child: Text(
                "You don't have any Todo\nAdd Some todo",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding:
                  EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: index == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                  "Completed ${_todos.countCompleted()}/${_todos.items.length}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            TodoCard(
                              title: _todos.items[index].title,
                              description: _todos.items[index].description,
                              priority: _todos.items[index].priority,
                              todoKey: _todos.items[index].id,
                              isCompleted: _todos.items[index].isCompleted,
                              category: _todos.items[index].category,
                              index: index,
                            ),
                          ],
                        )
                      : index == _todos.items.length - 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TodoCard(
                                  title: _todos.items[index].title,
                                  description: _todos.items[index].description,
                                  priority: _todos.items[index].priority,
                                  todoKey: _todos.items[index].id,
                                  isCompleted: _todos.items[index].isCompleted,
                                  category: _todos.items[index].category,
                                  index: index,
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            )
                          : TodoCard(
                              title: _todos.items[index].title,
                              description: _todos.items[index].description,
                              priority: _todos.items[index].priority,
                              todoKey: _todos.items[index].id,
                              isCompleted: _todos.items[index].isCompleted,
                              category: _todos.items[index].category,
                              index: index,
                            ),
                );
              },
              itemCount: _todos.items.length,
            ),
    );
  }
}
