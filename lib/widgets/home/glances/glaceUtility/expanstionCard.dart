import 'package:flutter/material.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        color:  Color(0xff262A3D),
        image: DecorationImage(
          image: AssetImage("assets/images/icon_images/mug_.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xff262A3D).withOpacity(0.6), BlendMode.darken)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ]
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(20),
        collapsedIconColor: Colors.white,
        collapsedTextColor: Colors.white,
        textColor: Colors.white,
        iconColor: Colors.white,
        title: Text("Book", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),),
        subtitle: Text("This is looking smooth"),
        leading: Icon(Icons.book),
        children: [
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BorderIconButton(icon: Icons.check, onPress: (){}),
              SizedBox(width: 5,),
              BorderIconButton(icon: Icons.edit, onPress: (){}),
              SizedBox(width: 5,),
              BorderIconButton(icon: Icons.delete, onPress: (){}),
            ],
          ),
        ],
      ),
    );
  }
}
