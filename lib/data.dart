import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static late SharedPreferences prefs;
  static Map<String, int> list = Map<String, int>();
  
  static void init() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, int> savedList = json.decode(prefs.getString("list").toString());
    // fill list with savedList
    savedList.forEach((key, value) {
      // list.addEntries({key, value});
      print(key);
      print(value);
    });
  }

  static  createTimer(String name, int hours, int minutes) {
    int nbMillisecond = (hours * 60 + minutes) * 60 * 1000;
    int timerEndDate = DateTime.now().millisecondsSinceEpoch + nbMillisecond;

    

    // prefs.setString("", timerEndDate);
  }
}