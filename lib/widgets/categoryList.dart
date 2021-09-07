import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';


class CategoryList extends StatelessWidget {
  final Function onPress;
  CategoryList({
    required this.onPress,
    Key? key}) : super(key: key);

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
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 20) ,
              itemBuilder: (context, ind){
              return TextButton(
                onPressed: (){
                  onPress(TypeCategory.values.elementAt(ind));
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                         ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(getTypeCategoryAddress(TypeCategory.values.elementAt(ind)), fit: BoxFit.contain, height: 70, )),
                      Text("${getTypeCategoryName(TypeCategory.values.elementAt(ind))}", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),)
                    ],
                  ),
                ),
              );
            },
              itemCount: TypeCategory.values.length,
            ),
          ],
        ),
      ),
    );
  }
}
