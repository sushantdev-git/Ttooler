import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQeury = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:mediaQeury.size.height/10, left: mediaQeury.size.width/10, right:mediaQeury.size.width/10 ),
        height: mediaQeury.size.height,
        width: mediaQeury.size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mediaQeury.size.height/3,
              width: mediaQeury.size.height/3,
              child: Center(child: Image.asset("assets/images/tree.png", fit: BoxFit.cover,)),
            ),

          ],
        ),
      ),
    );
  }
}
