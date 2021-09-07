import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoGreeting extends StatelessWidget {
  InfoGreeting({Key? key}) : super(key: key);

  final now = DateTime.now();
  String getGreet(){
    final morning = DateTime(now.year, now.month, now.day, 5, 0, 0);
    final afternoon = DateTime(now.year, now.month, now.day, 12, 0, 0);
    final evening = DateTime(now.year, now.month, now.day, 17, 00, 0);
    final night = DateTime(now.year, now.month, now.day, 20,00, 0);

    if(now.isAfter(morning) && now.isBefore(afternoon)){
      return "Morning";
    }
    else if(now.isAfter(afternoon) && now.isBefore(evening)){
      return "Afternoon";
    }
    else if(now.isAfter(evening) && now.isBefore(night)){
      return "Evening";
    }
    return "Night";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good ${getGreet()}",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 25,
                ),
              ),
              Text(
                "Sushant",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              Text(
                "${DateFormat("EEEE, dd MMM").format(now)}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          ),
          Container(
            child: Image.asset("assets/images/illustration/memoji.png", height: 100,),
          )
        ],
      ),
    );
  }
}
