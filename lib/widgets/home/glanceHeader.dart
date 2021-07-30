import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';

class GlanceHeader extends StatelessWidget {
  //this GlanceHeader widget is used to control the glance of HomePage
  //this widget and will render Header of glance
  final GlanceType glanceType;

  const GlanceHeader({
    required this.glanceType, Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if(glanceType == GlanceType.Todo)const GlanceIcon(imageAddress: "assets/images/icon_images/todo_icon.png",),
            if(glanceType == GlanceType.Reminder)const GlanceIcon(imageAddress: "assets/images/icon_images/reminder1.png",),
            if(glanceType == GlanceType.TimeTable)const GlanceIcon(imageAddress: "assets/images/icon_images/bookIcon.png",),
            SizedBox(
              width: 10,
            ),
            if(glanceType == GlanceType.Todo)const Text("Todo", style: glanceTypeHeadingStyle),
            if(glanceType == GlanceType.Reminder)const Text("Reminder", style: glanceTypeHeadingStyle),
            if(glanceType == GlanceType.TimeTable)const Text("TimeTable", style: glanceTypeHeadingStyle),
          ],
        ),
      ],
    );
  }
}

class GlanceIcon extends StatelessWidget {
  //this widget will render the icon image in side of glance header.
  final String imageAddress;
  const GlanceIcon({required this.imageAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Image.asset(imageAddress),
    );
  }
}
