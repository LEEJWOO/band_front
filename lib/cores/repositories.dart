import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'api.dart';
import 'dataclass.dart';

class MyInfo with ChangeNotifier {
  User? me;
  String? myRole;

  Future<bool> getMyInfo() async {
    //if test user, early return
    if (LogInApi.getUserName() == "Dummy_userA" ||
        LogInApi.getUserName() == "Dummy_userB" ||
        LogInApi.getUserName() == "Dummy_userC" ||
        LogInApi.getUserName() == "Dummy_userD") {
      log("current : ${LogInApi.getUserName()}");
      log("--- current profile ---");
      LogInApi.printAuth();
      return true;
    }

    var data = await ProfileApi.getMyInfo();
    if (data == null) {
      return false;
    }

    me = User.fromJson(data);
    if (me == null) {
      return false;
    }

    LogInApi.setUserName(me!.username);
    return true;
  }

  Future<bool> changeMyInfo(
      XFile? image, String? email, String? phNum, String? description) async {
    return await ProfileApi.changeMyInfo(email, phNum, description, image);
  }
}