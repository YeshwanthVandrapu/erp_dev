import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

import 'modal.dart';

class ScheduleController extends GetxController {
  List<ScheduleItem> items = [];
  bool addingEvent = false;

  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await File("res/json/HomepageUpcomingScheduleItems.json")
        .readAsString();
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(ScheduleItem.fromJson(i));
    }
    update();
  }

  void addEvent() {
    addingEvent = true;
    update();
  }
}
