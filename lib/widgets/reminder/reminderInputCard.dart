import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/widgets/categoryList.dart';

class AddReminderPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  final String cardTitle;
  final String title;
  final String description;
  final DateTime? datetime;
  final String ? id;
  final TypeCategory category;

  AddReminderPopupCard({
    required this.cardTitle,
    required this.title,
    required this.description,
    required this.datetime,
    required this.id,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  _AddReminderPopupCardState createState() => _AddReminderPopupCardState();
}

class _AddReminderPopupCardState extends State<AddReminderPopupCard> {
  String title = "";
  String description = "";
  final _form = GlobalKey<FormState>();
  TypeCategory category = TypeCategory.food;

  DateTime? dateTime;

  void saveData() {
    final _reminder = Provider.of<ReminderProvider>(context, listen: false);

    if (widget.id == null) {
      //if key is null then we have to add
      _reminder.addReminder(
        title: title,
        description: description,
        dateTime: dateTime!,
        category: category,
      );
    } else {
      //else we have to update the todo
      _reminder.updateReminder(
        title: title,
        description: description,
        dateTime: dateTime!,
        key: widget.id!,
        category: category,
      );
    }

    Navigator.of(context).pop();
  }


  Future<DateTime?> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime == null ? DateTime.now() : dateTime!,
      firstDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Theme.of(context).accentColor,
              onSurface: Theme.of(context).primaryColor,
            ),
            dialogBackgroundColor: Theme.of(context).accentColor,
          ),
          child: child!,
        );
      },
      lastDate: DateTime(DateTime.now().year + 5),
    );

    return pickedDate;
  }

  Future<TimeOfDay?> pickTime() async {
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: dateTime == null
            ? TimeOfDay.now()
            : TimeOfDay.fromDateTime(dateTime!));
    return pickedTime;
  }

  Future pickDateTime() async {
    final pickedDate = await pickDate();

    if (pickedDate == null) {
      return;
    }

    final pickedTime = await pickTime();

    if (pickedTime == null) {
      return;
    }

    dateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    setState(() {});
  }

  void validation() {
    if (dateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please choose date and time"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    }
    saveData();
  }

  void setCategory(TypeCategory c){
    setState(() {
      category = c;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    description = widget.description;
    dateTime = widget.datetime;
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
                    maxHeight: MediaQuery.of(context).size.height * (0.7)),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
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
                                    "${widget.cardTitle} Reminder",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color(0xff262A3D),
                                      // fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(Icons.notifications,color: Color(0xff262A3D)),
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
                                    labelStyle:
                                    TextStyle(color: Colors.black38),
                                    hintText: "Enter Title",
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
                                  if (value.length >= 20) {
                                    return "Title length must be under 20";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 18),
                                initialValue: description,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Description",
                                    labelStyle:
                                    TextStyle(color: Colors.black38),
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
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await pickDateTime();
                                      },
                                      child: dateTime == null
                                          ? Text("Pick Date Time")
                                          : Column(
                                              children: [
                                                Text(
                                                  "Pick Date Time",
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "${DateFormat("MMM dd - h:mm a").format(dateTime!)}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white70),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            content: CategoryList(onPress: setCategory,),
                                          ),
                                        );
                                      },
                                      label: Text("Choose Category"),
                                      icon: Icon(Icons.category),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if(_form.currentState!.validate()){
                                          validation();
                                        }
                                      },
                                      child: Container(
                                        width: minW ? 70: 100,
                                        child: Center(child: Text("Ok")),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
