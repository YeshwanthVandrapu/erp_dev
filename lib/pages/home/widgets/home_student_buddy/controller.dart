import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'modal.dart';

class StudentBuddyController extends GetxController {
  List<StudentBuddy> items = [];
  ScrollController scrollController = ScrollController();

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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
