import 'package:flutter/material.dart';


class BorderIconButton extends StatelessWidget {
  
  final Function onPress;
  final IconData icon;
  const BorderIconButton({required this.icon, required this.onPress});

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: (){
        onPress();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white54),
            borderRadius: BorderRadius.circular(100)
        ),
          child: Icon(icon, color: Colors.white,),
      ),
    ) ;
  }
}
