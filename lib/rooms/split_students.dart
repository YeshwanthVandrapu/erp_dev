import 'dart:convert';

import 'package:erp_dev/rooms/roommate.dart';
import 'package:flutter/services.dart';

Future<Map<String, Map<String, List<Roommate>>>> split() async {
  List<Roommate> items = [];
  String jsonString =
      await rootBundle.loadString("res/json/roommate_student_list.json");
  for (Map<String, dynamic> i in jsonDecode(jsonString)) {
    items.add(Roommate.fromJson(i));
  }

  Map<String, Map<String, List<Roommate>>> roommatesBySchoolAndSex = {};
  for (var roommate in items) {
    if (!roommatesBySchoolAndSex.containsKey(roommate.school)) {
      roommatesBySchoolAndSex[roommate.school] = {
        'Male': [],
        'Female': [],
      };
    }
    roommatesBySchoolAndSex[roommate.school]![roommate.sex]!.add(roommate);
  }
  return roommatesBySchoolAndSex;
}
