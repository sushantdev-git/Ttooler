import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class Todo{
  final String title;
  late String subtitle;
  final String description;
  final String key;
  int priority;

  Todo({required this.title, required this.subtitle , required this.description, required this.key,required this.priority});

}

class TodoProvider extends ChangeNotifier{

  List<Todo> _items =[];

  var queue = PriorityQueue<Todo>((a, b) => b.priority.compareTo(a.priority));

  List<Todo> get items {
    return [..._items];
  }

  void addTodo({required String title, required String subtitle, required String description, required int priority }){
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

   String updateTodo({required String title, required String subtitle, required String description, required String key, required int priority}){

    //we need the previous key to todo to remove that from the queue
    final todo = _items.firstWhere((todo) => todo.key == key);
    queue.remove(todo);

    //and then we create a new todo so it need a new key and new key will be current dateTime

    final keytoReturn = DateTime.now().toString();

    queue.add(Todo(title: title, subtitle: subtitle, description: description, key: keytoReturn, priority: priority));

    _items = queue.toList();

    notifyListeners();

    //and we return this key so we can change hero tag of edit button in todoinput card.
    return keytoReturn;
  }

  void printQueue(){
    List<Todo> temp = queue.toList();

    for(int i=0; i<temp.length; i++){
      print(temp[i].title);
      print(temp[i].priority);
    }
  }
}