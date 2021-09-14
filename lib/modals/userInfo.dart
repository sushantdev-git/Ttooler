import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ttooler/database/UserDatabase.dart';

class UserInfo extends ChangeNotifier{

  late final String ? name;
  late final byteImage;


  Future<void> addUserData(String name, String imageString) async{

    await UserDatabase.insert("user_info", {
      "id":"1",
      "username": name,
      "image": imageString,
    });
  }

  Future<void> fetchUserInfo() async {
    final data = await UserDatabase.getData("user_info");
    //setting _items list with getting data from database.
    name = data[0]['username'];
    byteImage = Base64Decoder().convert(data[0]['image']);

    notifyListeners();
  }
}