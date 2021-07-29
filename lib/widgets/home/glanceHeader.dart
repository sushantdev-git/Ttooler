import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';

class GlanceHeader extends StatelessWidget {
  //this GlanceHeader widget is used to control the glance of HomePage
  //this widget and will render Header of glance
  final GlanceType glanceType;
  final Function changeGlance;

  const GlanceHeader({
    required this.glanceType, required this.changeGlance, Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if(glanceType == GlanceType.Todo)GlanceIcon(imageAddress: "assets/images/icon_images/todo_icon.png",),
            if(glanceType == GlanceType.Reminder)GlanceIcon(imageAddress: "assets/images/icon_images/reminder1.png",),
            if(glanceType == GlanceType.TimeTable)GlanceIcon(imageAddress: "assets/images/icon_images/bookIcon.png",),
            SizedBox(
              width: 10,
            ),
            if(glanceType == GlanceType.Todo)Text("Todo", style: glanceTypeHeadingStyle),
            if(glanceType == GlanceType.Reminder)Text("Reminder", style: glanceTypeHeadingStyle),
            if(glanceType == GlanceType.TimeTable)Text("TimeTable", style: glanceTypeHeadingStyle),
          ],
        ),
        //here passing the changGlance function to BorderIconButton which we are getting from home page so when user press any of the arrow button
        //at any glance that function will be called and home page will change accordingly that.
        if(glanceType == GlanceType.Todo)BorderIconButton(
          icon: Icons.east,
          onPress: () => changeGlance(GlanceType.Reminder),
        ),
        if(glanceType == GlanceType.TimeTable)BorderIconButton(
          icon: Icons.west,
          onPress: () => changeGlance(GlanceType.Reminder),
        ),
        if(glanceType == GlanceType.Reminder)BorderIconButton(
          icon: Icons.west,
          onPress: () => changeGlance(GlanceType.Todo),
        ),
        if(glanceType == GlanceType.Reminder)BorderIconButton(
          icon: Icons.east,
          onPress: () => changeGlance(GlanceType.TimeTable),
        )
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
