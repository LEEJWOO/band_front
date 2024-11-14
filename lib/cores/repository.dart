import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'api.dart';
import 'data_class.dart';

class MyInfo with ChangeNotifier {
  User? me;

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

    me = User.fromMap(data);
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

class ClubDetail with ChangeNotifier {
  int? clubId;
  String? role; // 회장, 관리자, 일반
  Club? club;
  List<ActivityEntity> actList = [];
  int pnAct = 0;
  List<Member> members = [];
  int pnMem = 0;

  void _clear() {
    clubId = null;
    role = null;
    club = null;
    actList.clear();
    pnAct = 0;
    members.clear();
    pnMem = 0;
  }

  void _clearMember() {
    members.clear();
    pnMem = 2;
  }

  Future<bool> initClubDetail(int clubId, String role) async {
    _clear();
    this.clubId = clubId;
    this.role = role;
    await getClubDetail().then((bool result) {
      if (result == false) {
        return false;
      }
    });
    await getActivityList().then((bool result) {
      if (result == false) {
        return false;
      }
    });
    notifyListeners();
    return true;
  }

  Future<bool> getClubDetail() async {
    if (clubId == null) {
      log("get club detail failed");
      return false;
    }
    var data = await ClubApi.getClubDetail(clubId!);
    if (data == null) {
      log("get club detail failed");
      return false;
    }
    club = Club.fromMap(data);
    notifyListeners();
    return true;
  }

  Future<bool> getActivityList() async {
    if (clubId == null) {
      log("club id null in getActivityList");
      return false;
    }
    var data = await ActivityApi.getActivityList(clubId!, pnAct);
    var list = data['list'];
    for (Map<String, dynamic> element in list) {
      actList.add(ActivityEntity.fromMap(element));
    }
    pnAct++;
    notifyListeners();
    return true;
  }

  Future<void> getMemberList() async {
    _clearMember();
    var data = await ClubApi.getClubMemberList(clubId!, pnMem);
    var list = data['list'];
    for (Map<String, dynamic> element in list) {
      members.add(Member.fromMap(element));
    }
    pnMem++;
    notifyListeners();
    return;
  }
}

class ClubList with ChangeNotifier {
  List<ClubEntity> clubs = [];
  int pn = 0;

  void _clear() {
    clubs.clear();
    pn = 0;
  }

  Future<bool> initClubList() async {
    _clear();
    var data = await ClubApi.getMyClubList(pn);
    var list = data['list'];
    log("$data");
    for (Map<String, dynamic> element in list) {
      ClubEntity temp = ClubEntity.fromMap(element);
      if (temp.clubStatus != "운영종료") {
        clubs.add(temp);
      }
    }
    pn++;
    notifyListeners();
    return true;
  }

  Future<bool> getMoreClubList() async {
    var data = await ClubApi.getMyClubList(pn);
    var list = data['list'];
    log("$data");
    for (Map<String, dynamic> element in list) {
      ClubEntity temp = ClubEntity.fromMap(element);
      if (temp.clubStatus != "운영종료") {
        clubs.add(temp);
      }
    }
    pn++;
    notifyListeners();
    return true;
  }
}
