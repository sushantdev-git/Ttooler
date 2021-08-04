import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/pages/todoPage.dart';


class CategoryList extends StatelessWidget {
  CategoryList({Key? key}) : super(key: key);

  final List<String> _imageAddress = [
    "assets/images/tree.png",
    "assets/images/icon_images/mug_.png",
    "assets/images/icon_images/bookIcon.png",
    "assets/images/icon_images/reminder1.png",
    "assets/images/icon_images/todo_icon.png",
    "assets/images/icon_images/calender.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text("Choose Category", style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              // fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 10,),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 20) ,
              itemBuilder: (context, ind){
              return Container(
                child: Image.asset(_imageAddress[ind], fit: BoxFit.contain,),
              );
            },
              itemCount: _imageAddress.length,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 20) ,
              itemBuilder: (context, ind){
                return Container(
                  child: Image.asset(_imageAddress[ind], fit: BoxFit.contain,),
                );
              },
              itemCount: _imageAddress.length,
            ),
          ],
        ),
      ),
    );
  }
}
