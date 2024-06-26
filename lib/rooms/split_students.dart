import 'dart:convert';

import 'package:erp_dev/rooms/roommate.dart';
import 'package:flutter/services.dart';

void split() async {
  List<Roommate> items = [];
  String jsonString =
      await rootBundle.loadString("res/json/roommate_student_list.json");
  for (Map<String, dynamic> i in jsonDecode(jsonString)) {
    items.add(Roommate.fromJson(i));
  }
  print(items[0]);

  Map<String, List<Roommate>> studentsBySchool = {};

  for (Roommate r in items) {
    if (!studentsBySchool.containsKey(r.school)) {
      studentsBySchool[r.school] = [];
    }
    studentsBySchool[r.school]!.add(r);
  }
  List<String> schoolKeys = ["SIAS", "IFMR", "GSB"];
  for ()
}
