import 'dart:convert';

import 'package:erp_dev/pages/home/widgets/welcome_card/modal.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? user;
  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() async {
    final String response =
        await rootBundle.loadString("res/json/userinfo.json");
    final data = await json.decode(response);
    user = User.fromJson(data);
    update();
  }
}
