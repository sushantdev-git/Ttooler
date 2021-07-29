import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoGreeting extends StatelessWidget {
  const InfoGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sushant", style: TextStyle(
                fontSize: 25,
              ),),
              Text("Good Morning", style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 30,
              ),),
            ],
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Theme.of(context).backgroundColor,
          )
        ],
      ),
    );
  }
}
