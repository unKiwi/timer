import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static late SharedPreferences prefs;
  static Map<String, dynamic> list = Map<String, dynamic>();
  
  static void init() async {
    prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> savedList = json.decode(prefs.getString("list") ?? "{'1': '1'}".toString()) as Map<String, dynamic>;
    if (savedList == null) return;
    // fill list with savedList
    savedList.forEach((key, value) {
      // list.addEntries({key, value});
      list[key] = value;
    });
  }

  static void save() {
    prefs.setString("list", json.encode(list));
  }

  static  createTimer(String name, int hours, int minutes) {
    int nbMillisecond = (hours * 60 + minutes) * 60 * 1000;
    int timerEndDate = DateTime.now().millisecondsSinceEpoch + nbMillisecond;

    list[name] = timerEndDate;

    save();
  }
}