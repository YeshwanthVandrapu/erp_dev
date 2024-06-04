import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'modal.dart';

class StudentBuddyController extends GetxController {
  List<StudentBuddy> items = [];
  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await rootBundle.loadString("res/json/student_buddy.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(StudentBuddy.fromJson(i));
    }
    update();
  }
}
