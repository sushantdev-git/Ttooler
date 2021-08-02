import 'package:flutter/cupertino.dart';

class Todo{
  final String title;
  late String ? subtitle;
  final String content;
  final String key;

  Todo({required this.title, this.subtitle = "", required this.content, required this.key});

}

class TodoProvider extends ChangeNotifier{

  List<Todo> _items =[];

  get items {
    return [..._items];
  }

  void addTodo({required String title, String ? subtitle, required String content }){
    _items.add(
      Todo(title: title, content: content, subtitle: subtitle, key: DateTime.now().toString())
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

    _items.insert(index, Todo(title: title, content: content, key: key, subtitle: subtitle));
  }
}