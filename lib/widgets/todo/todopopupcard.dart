import 'package:flutter/material.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:provider/provider.dart';

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


  var initValues = {
    "title" : "",
    "price" : "",
    "description" : ""
  };

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

  void saveData(){
    final _todos = Provider.of<TodoProvider>(context, listen: false);
    _todos.addTodo(title: _titleTextController.text, description: _descriptionTextController.text, subtitle: _subtitleTextController.text);
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
              return CustomRectTween(begin: begin as Rect , end: end as Rect);
            },
            child: Material(
              color: Theme.of(context).accentColor,
              elevation: 4,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                          Text("Enter Todo", style: TextStyle(
                            fontSize: 25,
                            color: Color(0xff262A3D),
                            // fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Title",
                              ),
                              cursorColor: Colors.white,
                              controller: _titleTextController,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Subtitle",
                              ),
                              cursorColor: Colors.white,
                              controller: _subtitleTextController,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Color(0xff262A3D),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Description"
                              ),
                              cursorColor: Colors.white,
                              maxLines: null,
                              controller: _descriptionTextController,
                            ),
                          ),
                          SizedBox(height: 20,),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(onPressed: (){}, child: Text("Choose category")),
                                SizedBox(width: 30,),
                                ElevatedButton(onPressed: (){
                                  if(_titleTextController.text.length <= 2){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Input valid title")));
                                    return;
                                  }
                                  else if(_subtitleTextController.text.length <= 5){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Input valid subtitle")));
                                    return;
                                  }
                                  else if(_descriptionTextController.text.length <= 15){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Input valid description")));
                                    return;
                                  }
                                  saveData();
                                }, child: Text("Ok")),
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