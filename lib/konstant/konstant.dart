import 'package:flutter/material.dart';


enum GlanceType{
  Todo,
  Reminder,
  TimeTable
}

enum PageName{
  HomePage,
  Todo,
  Reminder,
  TimeTable,
  BookShelf,
  About
}

const glanceTypeHeadingStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

enum TypeCategory{
  study,
  play,
  phone,
  food,
  coding,
  work,
  others,
}

String getTypeCategoryAddress(TypeCategory category){

  final List<String> _imageAddress = [
    "assets/images/illustration/mug_.png",
    "assets/images/illustration/phone.png",
    "assets/images/illustration/pi.png",
    "assets/images/illustration/burger.png",
    "assets/images/illustration/football.png",
    "assets/images/illustration/officedesk.png",
    "assets/images/illustration/others.png",
  ];

  switch(category){
    case TypeCategory.phone:
      return _imageAddress[1];
    case TypeCategory.study:
      return _imageAddress[2];
    case TypeCategory.food:
      return _imageAddress[3];
    case TypeCategory.play:
      return _imageAddress[4];
    case TypeCategory.coding:
      return _imageAddress[0];
    case TypeCategory.work:
      return _imageAddress[5];
    case TypeCategory.others:
      return _imageAddress[6];
  }

}


String getTypeCategoryName(TypeCategory category){

  switch(category){
    case TypeCategory.phone:
      return "Phone";
    case TypeCategory.study:
      return "Study";
    case TypeCategory.food:
      return "Food";
    case TypeCategory.play:
      return "Play";
    case TypeCategory.coding:
      return "Coding";
    case TypeCategory.work:
      return "Work";
    case TypeCategory.others:
      return "Others";
  }
}