import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/widgets/categoryList.dart';

class AddTimetablePopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  final String cardTitle;
  final String title;
  final String description;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final String day;
  final String? id;
  final TypeCategory category;

  AddTimetablePopupCard({
    required this.cardTitle,
    required this.title,
    required this.day,
    required this.description,
    required this.fromTime,
    required this.toTime,
    required this.id,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  _AddTimetablePopupCardState createState() => _AddTimetablePopupCardState();
}

class _AddTimetablePopupCardState extends State<AddTimetablePopupCard> {
  String title = "";
  String description = "";
  final _form = GlobalKey<FormState>();

  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  String fromTimeDis = "";
  String toTimeDis = "";
  TypeCategory category = TypeCategory.food;
  bool isCategoryChosen = false;

  void saveData() async {
    final _timetable = Provider.of<TimeTableProvider>(context, listen: false);
    List<int> overlappingIndexes = _timetable.checkOverlapping(
        fromTime: fromTime!, toTime: toTime!, day: widget.day);
    final int currentScheduleIndex =
        _timetable.getCurrentScheduleIndex(widget.id, widget.day);
    bool overwrite = true;
    print(overlappingIndexes);
    if (overlappingIndexes[0] != -1 &&
        (overlappingIndexes[0] != currentScheduleIndex ||
            overlappingIndexes[0] == currentScheduleIndex &&
                overlappingIndexes.length > 1)) {
      //if olI contain -1 means no overlapping, if oLI contain one element and it is current item index then we should not pop up,
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              titleTextStyle: TextStyle(color: Colors.white),
              contentTextStyle: TextStyle(color: Colors.white),
              title: Text("Alert"),
              content: Text(
                  "Given time overlap with previous schedule\nDo you want to overwrite it."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      overwrite = false;
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      overwrite = true;
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
    if (widget.id == null && overwrite) {
      //if key is null then we have to add
      _timetable.add(
        title: title,
        description: description,
        fromTimeOfDay: fromTime!,
        toTimeOfDay: toTime!,
        whichDay: widget.day,
        overlappingIndexes:
            overlappingIndexes[0] == -1 ? [] : overlappingIndexes,
        category: category,
      );
    } else if (overwrite) {
      //else we have to update the todo
      overlappingIndexes.add(currentScheduleIndex);
      _timetable.add(
        title: title,
        description: description,
        fromTimeOfDay: fromTime!,
        toTimeOfDay: toTime!,
        whichDay: widget.day,
        overlappingIndexes: overlappingIndexes[0] == -1
            ? [currentScheduleIndex]
            : overlappingIndexes,
        category: category,
      );
    }
    if (overwrite) Navigator.of(context).pop();
  }

  Future<TimeOfDay?> pickTime(TimeOfDay? time, String whichTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: whichTime,
      initialTime: time == null ? TimeOfDay.now() : time,
    );
    return pickedTime;
  }

  Future pickDateTime(String whichTime) async {
    final pickedTime =
        await pickTime(whichTime == "From" ? fromTime : toTime, whichTime);

    if (pickedTime == null) {
      return;
    }

    if (whichTime == "From") {
      fromTime = pickedTime;
      formatTime(fromTime, "From");
    } else {
      toTime = pickedTime;
      formatTime(toTime, "To");
    }
  }

  void validation() {
    if (fromTime == null || toTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please pick time"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    } else if (fromTime!.hour > toTime!.hour ||
        (fromTime!.hour == toTime!.hour &&
            fromTime!.minute >= toTime!.minute)) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "From time cannot be greater than To time.\nYou can set schedule between 12:00AM to 11:59PM",
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            )),
        duration: Duration(milliseconds: 1500),
      ));
      return;
    }
    else if(!isCategoryChosen){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Please choose a category.",
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            )),
        duration: Duration(milliseconds: 1000),
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
    description = widget.description;
    fromTime = widget.fromTime;
    toTime = widget
        .toTime; //if widget datetime is null means this pop up card is called from FAB of timetable page.
    category = widget.category;
    final now = DateTime.now();
    if (fromTime != null)
      fromTimeDis = "\n" +
          DateFormat("hh:mm a").format(DateTime(
              now.year, now.month, now.day, fromTime!.hour, fromTime!.minute));
    if (toTime != null)
      toTimeDis = "\n" +
          DateFormat("hh:mm a").format(DateTime(
              now.year, now.month, now.day, toTime!.hour, toTime!.minute));
  }

  void formatTime(TimeOfDay? time, String whichTime) {
    final now = DateTime.now();

    if (time == null) {
      return;
    }

    final current = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if (whichTime == "From")
        fromTimeDis = "\n" + DateFormat("hh:mm a").format(current);
      if (whichTime == "To")
        toTimeDis = "\n" + DateFormat("hh:mm a").format(current);
    });
  }

  void setCategory(TypeCategory c) {
    setState(() {
      category = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    final minW = MediaQuery.of(context).size.width / 4 <= 90;
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
                                        "${widget.cardTitle} Schedule",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff262A3D),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.schedule,
                                        color: Color(0xff262A3D),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${widget.day}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff262A3D),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
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
                                      if (value.length <= 2) {
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
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 18),
                                    initialValue: description,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Description",
                                        labelStyle:
                                            TextStyle(color: Colors.black38),
                                        hintText:
                                            "Enter description",
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
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pick Time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff262A3D),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await pickDateTime("From");
                                              },
                                              child: Text(
                                                "From$fromTimeDis",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await pickDateTime("To");
                                              },
                                              child: Text(
                                                "To$toTimeDis",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              isCategoryChosen = true;
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  content: CategoryList(
                                                    onPress: setCategory,
                                                  ),
                                                ),
                                              );
                                            },
                                            label: Text("Choose Category"),
                                            icon: Icon(Icons.category),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_form.currentState!
                                                  .validate()) {
                                                validation();
                                              }
                                            },
                                            child: Container(
                                              width: minW ? 70 : 100,
                                              child: Center(child: Text("Ok")),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
