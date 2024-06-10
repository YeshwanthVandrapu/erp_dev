import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'modal.dart';

class HomeMenuController extends GetxController {
  final List<RawMenuModal> rmenus = [];
  List<MenuModal> menus = [];
  int cIndex = -1;
  int selected = -1;

  @override
  void onInit() async {
    super.onInit();
    rmenus.clear();
    menus.clear();
    loadJsonAsset();
  }

  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('res/json/jsonformmatter.json');
    var data = jsonDecode(jsonString);
    rmenus.clear();
    for (var e in data) {
      rmenus.add(RawMenuModal.fromJson(e));
    }
    menus.clear();
    menus.addAll(getMenu("0", rmenus));
    update();
  }

  List<MenuModal> getMenu(String pid, List<RawMenuModal> rmenus) {
    List<MenuModal> menus = [];
    List<RawMenuModal> rmenuss = [];
    for (var rmenu in rmenus) {
      if (pid != rmenu.parentId) {
        rmenuss.add(rmenu);
      }
    }
    for (var rmenu in rmenus) {
      // rmenus.remove(rmenu);
      if (pid == rmenu.parentId) {
        menus.add(MenuModal(
            resourceIcon: rmenu.resourceIcon,
            resourceId: rmenu.resourceId,
            resourceName: rmenu.resourceName,
            children: getMenu(rmenu.resourceId, rmenuss)));
      }
    }
    return menus;
  }
}
