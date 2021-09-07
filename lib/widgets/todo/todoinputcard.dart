import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/widgets/categoryList.dart';

class AddTodoPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  final String cardTitle;
  final String title;
  final String description;
  final double priority;
  final String? todoKey;
  final bool isCompleted;
  final TypeCategory category;
  AddTodoPopupCard(
      {
      required this.cardTitle,
      required this.title,
      required this.description,
      required this.priority,
      required this.todoKey,
      required this.isCompleted,
        required this.category,
      Key? key})
      : super(key: key);

  @override
  _AddTodoPopupCardState createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  String title = "";
  String subtitle = "";
  String description = "";
  String? key;
  TypeCategory category = TypeCategory.food;

  double priority = 0;

  final _form = GlobalKey<FormState>();

  void saveData() {
    final _todos = Provider.of<TodoProvider>(context, listen: false);
    if (widget.cardTitle == "Add") {
      _todos.addTodo(
        title: title,
        description: description,
        priority: priority.toInt(),
        category: category,
      );
    } else {
      _todos.updateTodo(
        title: title,
        key: widget.todoKey!,
        priority: priority.toInt(),
        description: description,
        isCompleted: widget.isCompleted,
        category: category,
      );
    }
    Navigator.of(context).pop();
  }

  void setCategory(TypeCategory c){
    setState(() {
      category = c;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    description = widget.description;
    priority = widget.priority;
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final minW = MediaQuery.of(context).size.width/4 <= 90;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height*(0.7)
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Form(
                              key: _form,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.cardTitle} Todo",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff262A3D),
                                          // fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(Icons.check_box,color: Color(0xff262A3D)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).backgroundColor,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600),
                                    initialValue: title,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Title",
                                        labelStyle: TextStyle(color: Colors.black38),
                                        hintText: "Enter todo",
                                        errorStyle: TextStyle(
                                          color: Colors.black54,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    cursorColor: Theme.of(context).canvasColor,
                                    maxLines: null,
                                    onChanged: (value) {
                                      title = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "Enter Title";
                                      }
                                      if (value.length <= 3) {
                                        return "Title length must be 3";
                                      }
                                      return null;
                                    },
                                  ),
                                  // Divider(height: 3, thickness: 1, color: Colors.black38,),
                                  TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).backgroundColor,
                                        fontSize: 18),
                                    initialValue: description,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Description",
                                        labelStyle: TextStyle(color: Colors.black38),
                                        hintText: "Enter description",
                                        errorStyle: TextStyle(
                                          color: Colors.black54,
                                          fontStyle: FontStyle.italic,
                                        )),
                                    cursorColor: Theme.of(context).canvasColor,
                                    maxLines: null,
                                    onChanged: (value) {
                                      description = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "Enter Description";
                                      }
                                      if (value.length <= 8) {
                                        return "Description length must be 8";
                                      }
                                      return null;
                                    },
                                  ),
                                  // Divider(height: 3, thickness: 1, color: Colors.black38,),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Set priority",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff262A3D),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Slider(
                                    inactiveColor: Color(0xff181920),
                                    activeColor: Color(0xff181920),
                                    onChanged: (value) {
                                      setState(() {
                                        priority = value;
                                      });
                                    },
                                    value: priority,
                                    divisions: 10,
                                    min: 0,
                                    max: 10,
                                    label: "${priority.toInt()}",
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    backgroundColor: Theme.of(context)
                                                        .primaryColor,
                                                    content: CategoryList(onPress: setCategory,),
                                                  ));
                                        },
                                        label: Text("Choose Category"),
                                        icon: Icon(Icons.category),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_form.currentState!.validate()) {
                                            saveData();
                                          }
                                        },
                                        child: Container(
                                            width: minW ? 60 : 100,
                                            child: Center(child: Text("Ok"))
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          print("hello");
                          Navigator.of(context).pop();
                        },
                        icon: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
