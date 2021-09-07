import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:ttooler/database/todoDatabase.dart';
import 'package:ttooler/konstant/konstant.dart';

class Todo {
  final String title;
  final String description;
  final String id;
  int priority;
  bool isCompleted;
  final TypeCategory category;
  final DateTime creationTime;
  Todo(
      {required this.title,
      required this.description,
      required this.id,
      required this.priority,
      required this.isCompleted,
        required this.category,
        required this.creationTime,
      }
  );
}

class TodoProvider extends ChangeNotifier {
  List<Todo> _items = [];

  var queue = PriorityQueue<Todo>((a, b) => comp(a,b));

  List<Todo> get items {
    return [..._items];
  }

  void addTodo(
      {required String title,
      required String description,
      required int priority,
        required TypeCategory category,
      }) async {
    final now = DateTime.now();
    queue.add(Todo(
        title: title,
        description: description,
        id: now.toString(),
        priority: priority,
        isCompleted: false,
       category: category,
      creationTime: now,
    ));
    _items = queue.toList();
    await TodoDatabase.insert({
      "id": now.toString(),
      "title": title,
      "description": description,
      "priority": priority,
      "isCompleted": 0,
      "category":category.index,
      "time": now.toIso8601String(),
    });
    notifyListeners();
  }

  void deleteTodo({required String key}) async {
    queue.remove(_items.firstWhere((element) => element.id == key));
    await TodoDatabase.delete(key);
    _items = queue.toList();
    notifyListeners();
  }

  void updateTodo(
      {required String title,
      required String description,
      required String key,
      required int priority,
      required bool isCompleted,
        required TypeCategory category,
      }) async {
    //we need the previous key to todo to remove that from the queue
    final todo = _items.firstWhere((todo) => todo.id == key);
    queue.remove(todo);

    queue.add(Todo(
        title: title,
        description: description,
        id: key,
        priority: priority,
        isCompleted: isCompleted,
      category: category,
      creationTime: todo.creationTime,
    ));
    await TodoDatabase.update({
      "id": key,
      "title": title,
      "description": description,
      "priority": priority,
      "isCompleted": isCompleted ? 1 : 0,
      "category":category.index,
    }, key);
    _items = queue.toList();

    notifyListeners();
  }

  void markCompleted(String key) async {
    print("hwllo");
    final item = _items.firstWhere((element) => element.id == key);
    print(queue.remove(item));
    item.isCompleted = !item.isCompleted;
    await TodoDatabase.update({
      "id": key,
      "title": item.title,
      "description": item.description,
      "priority": item.priority,
      "isCompleted": item.isCompleted ? 1: 0,
      "category":item.category.index,
    }, key);
    queue.add(item);
    print(queue.length);
    _items = queue.toList();
    notifyListeners();
  }

  int countCompleted (){
    int s = 0;

    for(int i=0; i<_items.length; i++){
      if(_items[i].isCompleted){
        s++;
      }
    }

    return s;
  }

  Future<void> fetchAndSetData() async {
    final List<Map<String, dynamic>> data = await TodoDatabase.getData();

    print(data);

    _items = data
        .map((item) => Todo(
            title: item["title"],
            description: item["description"],
            id: item["id"],
            priority: item["priority"],
            isCompleted: item["isCompleted"] == 1,
            category: TypeCategory.values.elementAt(item["category"]),
            creationTime: DateTime.parse(item["time"] as String),
    ))
        .toList();

    print(_items.length);
    queue.clear();
    for (int i = 0; i < _items.length; i++) {
      queue.add(_items[i]);
    }

    _items = queue.toList();
    notifyListeners();
  }
}

int comp(Todo a, Todo b){
  // print(a.isCompleted);
  // print(b.isCompleted);
  // print("---------------");
  //this function compare two todo on different aspects.
  if(a.isCompleted && !b.isCompleted){
    return 1;
  }
  else if(!a.isCompleted && b.isCompleted){
    return -1;
  }
  else if(a.priority > b.priority){
    return -1;
  }
  else if(a.priority < b.priority){
    return 1;
  }
  else if(a.priority == b.priority && a.creationTime.isAfter(b.creationTime)){
    return 1;
  }
  else if(a.priority == b.priority && a.creationTime.isAtSameMomentAs(b.creationTime)){
    return 0;
  }
  return -1;
}