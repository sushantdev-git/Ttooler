import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/timetable/timetableinputcard.dart';

class TimetableFloatingAB extends StatelessWidget {

  final String currentDay;
  const TimetableFloatingAB({
    required this.currentDay,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: GestureDetector(
      onTap: (){
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return AddTimetablePopupCard(title: "", day: currentDay, description: "", fromTime: null, toTime: null, cardTitle: "Add", id: null, category: TypeCategory.study,);
        },));
      },
      child: Material(
        elevation: 2,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Icon(
          Icons.add,
          size: 56,
          color: Color(0xff262A3D),
        ),
      ),
    ),);
  }
}