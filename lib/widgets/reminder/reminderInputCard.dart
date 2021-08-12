import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/widgets/todo/categoryList.dart';

import '../customRectTween.dart';

class AddReminderPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  late final String heroTag;
  final String cardTitle;
  final String title;
  final String subtitle;
  final String description;
  final DateTime? datetime;

  AddReminderPopupCard({
    required this.heroTag,
    required this.cardTitle,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.datetime,
    Key? key,
  }) : super(key: key);

  @override
  _AddReminderPopupCardState createState() => _AddReminderPopupCardState();
}

class _AddReminderPopupCardState extends State<AddReminderPopupCard> {
  String title = "";
  String subtitle = "";
  String description = "";
  String? key;
  late String hero;

  DateTime? dateTime;

  void saveData() {
    final _reminder = Provider.of<ReminderProvider>(context, listen: false);

    if (key == null) { //if key is null then we have to add
      _reminder.addReminder(
        title: title,
        description: description,
        subtitle: subtitle,
        dateTime: dateTime!,
      );
    } else { //else we have to update the todo
      setState(() {
        hero = dateTime.toString()+"Edit"; //this updated todo will going to have the same key as dateTime.toString()+"Edit"
        //so we use to here to update the hero tag of our pop up card
      });
      _reminder.updateReminder(
        title: title,
        subtitle: subtitle,
        description: description,
        dateTime: dateTime!,
        key: key!,
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
    } else if (dateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please choose date and time"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    }
    saveData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    subtitle = widget.subtitle;
    description = widget.description;
    dateTime = widget.datetime;
    key = widget.datetime != null ? widget.datetime.toString() : null; //if widget datetime is null means this pop up card is called from add todo
    hero = widget.heroTag;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * (0.7)),
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
                            "${widget.cardTitle} Reminder",
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
                              onChanged: (val) {
                                title = val;
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
                              onChanged: (val) {
                                subtitle = val;
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
                              onChanged: (val) {
                                description = val;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await pickDateTime();
                                    },
                                    child: Text("Pick Date Time")),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              content: CategoryList(),
                                            ));
                                  },
                                  label: Text("Choose Category"),
                                  icon: Icon(Icons.category),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    validation();
                                  },
                                  child: Text("Ok"),
                                ),
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
