import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

class Todo{
  final String title;
  late String ? subtitle;
  final String description;
  final String key;
  int priority;

  Todo({required this.title, this.subtitle = "", required this.description, required this.key, this.priority = 0});

}

class TodoProvider extends ChangeNotifier{

  List<Todo> _items =[];

  var queue = PriorityQueue<Todo>((a, b) => b.priority.compareTo(a.priority));

  List<Todo> get items {
    return [..._items];
  }

  void addTodo({required String title, String ? subtitle, required String description, required int priority }){
    queue.add(
        Todo(title: title, description: description, subtitle: subtitle, key: DateTime.now().toString(), priority: priority)
    );
    _items = queue.toList();
    notifyListeners();
  }

  void deleteTodo({required String key}){
    _items.removeWhere((todo) => todo.key == key);
    notifyListeners();
  }

  void editTodo({required String title, String ? subtitle, required String content, required String key}){

    final int index = _items.indexWhere((todo) => todo.key == key);

    final Todo todo = _items[index];

    _items.insert(index, Todo(title: title, description: content, key: key, subtitle: subtitle));
  }

  void printQueue(){
    List<Todo> temp = queue.toList();

    for(int i=0; i<temp.length; i++){
      print(temp[i].title);
      print(temp[i].priority);
    }
  }
}