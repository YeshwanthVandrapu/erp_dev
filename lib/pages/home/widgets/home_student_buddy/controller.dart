import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'modal.dart';

class StudentBuddyController extends GetxController {
  List<StudentBuddy> items = [];
  bool addingEvent = false;
  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await rootBundle.loadString("res/json/quicklink.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(StudentBuddy.fromJson(i));
    }
    update();
  }

  void addEvent() {
    addingEvent = true;
    update();
  }
}
