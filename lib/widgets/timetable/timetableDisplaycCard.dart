import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/timetable/timetableinputcard.dart';

import '../popUpCard.dart';

class TimetableCard extends StatelessWidget {
  final String title;
  final String description;
  final int index;
  final String day;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;
  final String id;
  final TypeCategory category;

  TimetableCard(
      {required this.title,
      required this.description,
      required this.index,
      required this.day,
      required this.fromTime,
      required this.toTime,
      required this.id,
        required this.category,
      });

  String getTimeRange() {
    final now = DateTime.now();

    final from = DateTime(
      now.year,
      now.month,
      now.day,
      fromTime.hour,
      fromTime.minute,
    );

    final to = DateTime(
      now.year,
      now.month,
      now.day,
      toTime.hour,
      toTime.minute,
    );

    return DateFormat("h:mm aa").format(from) +
        " - " +
        DateFormat("h:mm aa").format(to);
  }

  @override
  Widget build(BuildContext context) {
    final _timetable = Provider.of<TimeTableProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff262A3D),
          image: DecorationImage(
              image: AssetImage(getTypeCategoryAddress(category)),
              fit: BoxFit.cover,
              alignment: Alignment.topRight,
              colorFilter: ColorFilter.mode(
                  Color(0xff262A3D).withOpacity(0.8), BlendMode.darken)),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ]),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        //This will remove the highlight color from expansion tile.
        data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10),
          childrenPadding:
              EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.w700
            ),
          ),
          subtitle: Text(
            getTimeRange(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(description.length != 0)Text(
              description,
              softWrap: true,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(
                  icon: Icons.edit,
                  onPress: () {
                    Navigator.of(context).push(HeroDialogRoute(
                      builder: (context) {
                        return AddTimetablePopupCard(
                          cardTitle: "Edit",
                          title: title,
                          description: description,
                          day: day,
                          fromTime: fromTime,
                          toTime: toTime,
                          id: id,
                          category: category,
                        );
                      },
                    ));
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                BorderIconButton(
                  icon: Icons.delete,
                  onPress: () {
                    Navigator.of(context).push(
                      HeroDialogRoute(
                        builder: (context) {
                          return PopUpCard(
                            title: "Delete Schedule",
                            subtitle: "Do you want to delete Schedule?",
                            content: "$title (${getTimeRange()})",
                            onPress: () {
                              _timetable.removeSchedule(
                                  id, day);
                            },
                            icon: Icons.delete,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
