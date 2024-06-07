import 'dart:convert';
import 'package:erp_dev/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'modal.dart';

class HomeMenuController extends GetxController {
  final List<RawMenuModal> rmenus = [];
  List<MenuModal> menus = [];
  int cIndex = -1;

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

  Widget childSideMenu() {
    if (cIndex == -1 || menus[cIndex].children.isEmpty) {
      return const SizedBox.shrink();
    }
    return Material(
      child: MouseRegion(
        onExit: (event) {
          menus[cIndex].isSelected = false;
          cIndex = -1;

          update();
        },
        child: Container(
          width: 220,
          color: const Color(0xff275C9D),
          child: ListView.builder(
            itemCount: menus[cIndex].children.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  for (var d in menus) {
                    d.isSelected = false;
                  }
                  menus[cIndex].children[index].isSelected = true;
                  // data.clickIndex = index;
                  cIndex = index;
                  update();
                },
                child: ExpansionTile(
                  // trailing: () {
                  //   if (controller.menus[controller.cIndex].children[index]
                  //       .children.isNotEmpty) {
                  //     return const Icon(Icons.arrow_drop_down_outlined);
                  //   } else {
                  //     return const SizedBox.shrink();
                  //   }
                  // }(),
                  iconColor: const Color(0xffBDE2EE),
                  collapsedIconColor: const Color(0xffBDE2EE),
                  backgroundColor: const Color.fromARGB(255, 71, 128, 199),
                  // enableFeedback: true,
                  leading: CustomMaterialIcon(
                    menus[cIndex].children[index].resourceIcon,
                    color: menus[cIndex].children[index].isSelected
                        ? const Color.fromARGB(255, 71, 128, 199)
                        : const Color(0xffBDE2EE),
                  ),
                  title: Text(
                    menus[cIndex].children[index].resourceName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xffBDE2EE), fontSize: 12),
                  ),
                  children: menus[cIndex].children[index].children.map((data) {
                    return ListTile(
                      title: Text(
                        data.resourceName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffBDE2EE), fontSize: 10),
                      ),
                      leading: CustomMaterialIcon(
                        data.resourceIcon,
                        color: const Color(0xffBDE2EE),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
