import 'package:flutter/material.dart';


class PopUpCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;
  final Function onPress;
  final IconData icon;
  const PopUpCard({required this.title,required this.subtitle, required this.content, required this.onPress, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * (0.7)),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("$title", style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff262A3D),
                                  fontWeight: FontWeight.w700
                                ),),
                                SizedBox(width: 5,),
                                Icon(icon,color: Color(0xff262A3D),),
                              ],
                            ),
                            Text("$subtitle",style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff262A3D),
                              // fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 10,),
                            Text("$content", style: TextStyle(
                              fontSize: 17,
                              color: Color(0xff262A3D),
                              // fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                )),
                                SizedBox(width: 20,),
                                Expanded(child: ElevatedButton(
                                  onPressed: (){
                                    onPress();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"),
                                ))
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
