import 'package:flutter/material.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/widgets/todo/categoryList.dart';
import '../customRectTween.dart';

class AddTodoPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  late final String heroTag;
  final String cardTitle;
  final String title;
  final String subtitle;
  final String description;
  final double priority;
  final String ? todoKey;
  AddTodoPopupCard({required this.heroTag, required this.cardTitle, required this.title, required this.subtitle, required this.description, required this.priority, required this.todoKey, Key? key}) : super(key: key);

  @override
  _AddTodoPopupCardState createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  String title = "";
  String subtitle = "";
  String description = "";
  String? key;
  late String hero;

  double priority = 1;


  void saveData() {
    final _todos = Provider.of<TodoProvider>(context, listen: false);
    if(widget.cardTitle == "Add") {
      _todos.addTodo(
        title: title,
        description: description,
        subtitle: subtitle,
        priority: priority.toInt(),
      );
    }
    else{
      setState(() {
        hero = _todos.updateTodo(title: title, description: description, subtitle: subtitle, key: widget.todoKey!, priority: priority.toInt())+"Edit";
      });
    }
    Navigator.of(context).pop();
  }

  void validation() {

    if (title.length <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title length must be 3"),
          duration: Duration(milliseconds: 400),
        ),
      );
      return;
    } else if (subtitle.length <= 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Subtitle length must be 5"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    } else if (description.length <= 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Description length must be 10"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    }

    saveData();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    subtitle = widget.subtitle;
    description = widget.description;
    hero = widget.heroTag;
    priority = widget.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height*(0.7)
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: hero,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin as Rect, end: end as Rect);
            },
            child: Material(
              color: Theme.of(context).accentColor,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      // key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.cardTitle} Todo",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff262A3D),
                              // fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              initialValue: title,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Title",
                              ),
                              cursorColor: Colors.white,
                              onChanged: (value){
                                title = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              initialValue: subtitle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Subtitle",
                              ),
                              cursorColor: Colors.white,
                              onChanged: (value){
                                subtitle = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              initialValue: description,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Description"),
                              cursorColor: Colors.white,
                              maxLines: null,
                              onChanged: (value){
                                description = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Set priority", style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),),
                          Slider(
                            inactiveColor: Color(0xff181920),
                            activeColor: Color(0xff181920),
                            onChanged: (value){
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
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(onPressed: (){
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    content: CategoryList(),
                                  ));
                                }, label: Text("Choose Category"), icon: Icon(Icons.category),),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      validation();
                                    },
                                    child: Text("Ok"),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


