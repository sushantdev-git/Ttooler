import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:collection/collection.dart';

class Statistics extends StatelessWidget {
  final Function onPress;
  final String day;
  const Statistics({
    required this.onPress,
    required this.day,
    Key? key
  }) : super(key: key);


  List<int> getTimeCategoryWise(BuildContext context){
    final timeTable = Provider.of<TimeTableProvider>(context, listen: false);
    final List<int> times = [];
    for(int i=0; i<TypeCategory.values.length; i++) {
      times.add(
          timeTable.getCategoryWiseTime(TypeCategory.values.elementAt(i), day));
    }
    return times;
  }


  @override
  Widget build(BuildContext context) {
    final minW = MediaQuery.of(context).size.width/4 <= 90;
    final List<int> times = getTimeCategoryWise(context);
    final List<Color> colors = [
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.blueAccent,
      Colors.limeAccent,
      Colors.deepOrangeAccent,
      Colors.greenAccent,
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * (0.7)),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
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
                            Text("Stats", style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),),
                            Text("see your schedule division", style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) => times[index] == 0 ? Container() : Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${getTypeCategoryName(TypeCategory.values.elementAt(index))}", style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),),
                                        Row(
                                          children: [
                                            if(times[index]~/60 != 0)Text("${times[index]~/60}hr", style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                            ),),
                                            Text(" ${times[index]%60}min", style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                            ),),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height:5),
                                    Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: ((MediaQuery.of(context).size.width-64)/(24*60))*times[index],
                                            decoration: BoxDecoration(
                                              color: colors[index],
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ) ,
                              itemCount: TypeCategory.values.length,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Time left", style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),),
                                Row(
                                  children: [
                                    Text("${(24*60 - times.sum)~/60}hr ${(24*60 - times.sum)%60}min", style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: ((MediaQuery.of(context).size.width-64)/(24*60))*(24*60 - (times.sum)),
                                    decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          print("hello");
                          Navigator.of(context).pop();
                        },
                        icon: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ),
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