import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/widgets/todo/categoryList.dart';
import '../customRectTween.dart';

class AddTimetablePopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  late final String heroTag;
  final String cardTitle;
  final String title;
  final String description;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final String day;

  AddTimetablePopupCard({
    required this.heroTag,
    required this.cardTitle,
    required this.title,
    required this.day,
    required this.description,
    required this.fromTime,
    required this.toTime,
    Key? key,
  }) : super(key: key);

  @override
  _AddTimetablePopupCardState createState() => _AddTimetablePopupCardState();
}

class _AddTimetablePopupCardState extends State<AddTimetablePopupCard> {
  String title = "";
  String description = "";
  String? key;
  late String hero;

  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  String fromTimeDis = "";
  String toTimeDis = "";

  void saveData() async {
    final _timetable = Provider.of<TimeTableProvider>(context, listen: false);

    if (key == null) {
      //if key is null then we have to add
      List<int> overlappingIndexes = _timetable.checkOverlapping(fromTime: fromTime!, toTime: toTime!, day: widget.day);
      bool overwrite = true;
      if(overlappingIndexes[0] != -1){
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle: TextStyle(color: Colors.white),
            contentTextStyle: TextStyle(color: Colors.white),
            title: Text("Alert"),
            content: Text("Given time overlap with previous schedule\nDo you want to overwrite it."),
            actions: [
              ElevatedButton(onPressed: (){
                overwrite = false;
                Navigator.of(context).pop();
              }, child: Text("Cancel")),
              ElevatedButton(onPressed: (){
                overwrite = true;
                Navigator.of(context).pop();
              }, child: Text("Ok")),
            ],
          );
        });
      }
      if(overwrite) _timetable.add(
        title: title,
        description: description,
        fromTimeOfDay: fromTime!,
        toTimeOfDay: toTime!,
        whichDay: widget.day,
        overlappingIndexes: overlappingIndexes[0] == -1 ? [] : overlappingIndexes,
      );
    } else {
      //else we have to update the todo
      setState(() {
        hero = fromTime.toString() +
            "Edit"; //this updated todo will going to have the same key as dateTime.toString()+"Edit"
        //so we use to here to update the hero tag of our pop up card
      });
      //add update time of etc.
    }
    Navigator.of(context).pop();
  }

  Future<TimeOfDay?> pickTime(TimeOfDay? time, String whichTime) async {
    final pickedTime = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        helpText: whichTime,
        initialTime: time == null ? TimeOfDay.now() : time);
    return pickedTime;
  }

  Future pickDateTime(String whichTime) async {
    final pickedTime = await pickTime(whichTime == "From" ? fromTime : toTime, whichTime);

    if (pickedTime == null) {
      return;
    }

    if(whichTime == "From"){
      fromTime = pickedTime;
      formatTime(fromTime, "From");
    }
    else{
      toTime = pickedTime;
      formatTime(toTime, "To");
    }
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
    } else if (description.length <= 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Description length must be 10"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    } else if (fromTime == null || toTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please pick time"),
        duration: Duration(milliseconds: 400),
      ));
      return;
    }
    else if(fromTime!.hour > toTime!.hour || (fromTime!.hour == toTime!.hour && fromTime!.minute >= toTime!.minute)){
      print(fromTime!.hour);
      print(fromTime!.minute);
      print(toTime!.hour);
      print(toTime!.minute);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("From time cannot be greater than To time.\nYou can set schedule between 12:00AM to 11:59PM", style: TextStyle(
          fontSize: 12,
        )),
        duration: Duration(milliseconds: 1100),
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
    toTime = widget.toTime;
    key = widget.fromTime != null
        ? widget.fromTime.toString()
        : null; //if widget datetime is null means this pop up card is called from FAB of timetable page.
    hero = widget.heroTag;
  }

  void formatTime(TimeOfDay? time, String whichTime){
    final now  = DateTime.now();

    if(time == null){
      return;
    }

    final current =  DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if(whichTime == "From") fromTimeDis = "\n"+DateFormat("hh:mm a").format(current);
      if(whichTime == "To") toTimeDis = "\n"+DateFormat("hh:mm a").format(current);
    });
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
                            "${widget.cardTitle} Schedule",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff262A3D),
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await pickDateTime("From");
                                  },
                                  child: Text("From$fromTimeDis", textAlign: TextAlign.center,),
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
                                  child: Text("To$toTimeDis", textAlign: TextAlign.center,),
                                ),
                              )
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
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    validation();
                                  },
                                  child: Container(
                                      width: 100,
                                      child: Center(child: Text("Ok")),
                                  ),
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
