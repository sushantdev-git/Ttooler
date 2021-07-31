import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/home/glances/glaceUtility/expanstionCard.dart';

class TodoGlance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: Column(
        children: [
          GlanceHeader(glanceType: GlanceType.Todo,),
          SizedBox(height: 20,),
          TodoCard(),
          SizedBox(height: 15,),
          TodoCard(),
          SizedBox(height: 15,),
          TodoCard(),
          SizedBox(height: 15,),
          TodoCard(),
          SizedBox(height: 15,),
          TodoCard()
        ],
      ),
    );
  }
}
