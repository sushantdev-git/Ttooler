import 'package:flutter/material.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/widgets/todo/categoryList.dart';

class AddTodoPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  _AddTodoPopupCardState createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  late GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _subtitleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  double _slideValue = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _form.currentState!.dispose();
    super.dispose();
  }

  void saveData() {
    final _todos = Provider.of<TodoProvider>(context, listen: false);
    _todos.addTodo(
        title: _titleTextController.text,
        description: _descriptionTextController.text,
        subtitle: _subtitleTextController.text,
      priority: _slideValue.toInt(),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: "TodoButton",
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin as Rect, end: end as Rect);
            },
            child: Material(
              color: Theme.of(context).accentColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
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
                            "Enter Todo",
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Title",
                              ),
                              cursorColor: Colors.white,
                              controller: _titleTextController,
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Subtitle",
                              ),
                              cursorColor: Colors.white,
                              controller: _subtitleTextController,
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
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Description"),
                              cursorColor: Colors.white,
                              maxLines: null,
                              controller: _descriptionTextController,
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
                                  _slideValue = value;
                                });
                            },
                            value: _slideValue,
                            divisions: 10,
                            min: 0,
                            max: 10,
                            label: "${_slideValue.toInt()}",

                          ),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(onPressed: (){
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    content: CategoryList(),
                                  ));
                                }, label: Text("Choose Category"), icon: Icon(Icons.category),),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_titleTextController.text.length <=
                                          2) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Enter valid title"),
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        );
                                        return;
                                      } else if (_subtitleTextController
                                              .text.length <=
                                          4) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Enter valid subtitle"),
                                          duration: Duration(milliseconds: 400),
                                        ));
                                        return;
                                      } else if (_descriptionTextController
                                              .text.length <=
                                          10) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Enter valid description"),
                                          duration: Duration(milliseconds: 400),
                                        ));
                                        return;
                                      }
                                      saveData();
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
