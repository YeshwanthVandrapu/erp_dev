import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'modal.dart';

class QuickLinkController extends GetxController {
  List<QuickLink> items = [];
  bool addingEvent = false;
  @override
  void onInit() async {
    super.onInit();
    items.clear();
    // String rawJson = await rootBundle.loadString("res/json/quicklink.json");
    String rawJson = await rootBundle.loadString("res/json/quicklink2.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(QuickLink.fromJson(i));
    }
    update();
  }

  void addEvent() {
    addingEvent = true;
    update();
  }
}
