import 'package:flutter/cupertino.dart';

class Todo{
  final String title;
  late String ? subtitle;
  final String description;
  final String key;

  Todo({required this.title, this.subtitle = "", required this.description, required this.key});

}

class TodoProvider extends ChangeNotifier{

  List<Todo> _items =[];

  List<Todo> get items {
    return [..._items];
  }

  void addTodo({required String title, String ? subtitle, required String description }){
    _items.add(
      Todo(title: title, description: description, subtitle: subtitle, key: DateTime.now().toString())
    );
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
}