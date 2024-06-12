import 'dart:convert';
import 'package:erp_dev/pages/home/widgets/faq_page/test.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  List<FaqModal> items = [];
  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await rootBundle.loadString("res/json/faq.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(FaqModal.fromJson(i));
    }
    update();
  }
}
