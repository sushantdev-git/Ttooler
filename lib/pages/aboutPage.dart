import 'package:flutter/material.dart';
import 'package:ttooler/notification/notifications.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
          elevation: 2,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Theme(
                      data: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).backgroundColor,
                        tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        childrenPadding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        title: Text(
                          "1. Not getting notification",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        children: [
                          Text("Check if background activity is not restricted for this app.", style: TextStyle(
                            fontSize: 14,
                          ),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Theme(
                      data: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        backgroundColor: Theme.of(context).backgroundColor,
                        tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        childrenPadding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        title: Text(
                          "1. Not getting notification Sound",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        children: [
                          Text("Check in notification settings for this app, notification with sound is allowed.", style: TextStyle(
                            fontSize: 14,
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Designed and Developed By",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Sushant Mishra \nChandigarh | India",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
