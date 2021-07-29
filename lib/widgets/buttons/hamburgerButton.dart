import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HamburgerButton extends StatelessWidget {
  const HamburgerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 5, color: Colors.white,),
          SizedBox(height: 5,),
          Container(width: 35, height: 5, color: Colors.white,),
          SizedBox(height: 5,),
          Container(width: 30, height: 5, color: Colors.white,)
        ],
      ),
    );
  }
}
