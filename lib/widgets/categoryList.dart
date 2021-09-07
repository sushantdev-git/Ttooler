import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CategoryList extends StatelessWidget {
  CategoryList({Key? key}) : super(key: key);

  final List<String> _imageAddress = [
    "assets/images/illustration/tree.png",
    "assets/images/illustration/phone.png",
    "assets/images/illustration/pi.png",
    "assets/images/illustration/burger.png",
    "assets/images/illustration/football.png",
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
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20) ,
              itemBuilder: (context, ind){
              return TextButton(
                onPressed: (){},
                child: Container(
                  child: Image.asset(_imageAddress[ind], fit: BoxFit.contain,),
                ),
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
