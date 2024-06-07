import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'modal.dart';

class ScheduleController extends GetxController {
  List<ScheduleItem> items = [];
  bool addingEvent = false;
  double sWidth = 0;

  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await rootBundle
        .loadString("res/json/homepage_upcoming_schedule_items.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(ScheduleItem.fromJson(i));
    }
    update();
  }
}
