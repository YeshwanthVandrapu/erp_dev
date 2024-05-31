import 'dart:convert';
import 'package:erp_dev/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modal.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  final List<RawMenuModal> rmenus = [];
  List<MenuModal> menus = [];
  int cIndex = -1;

  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('res/json/jsonformmatter.json');
    var data = jsonDecode(jsonString);
    rmenus.clear();
    for (var e in data) {
      rmenus.add(RawMenuModal.fromJson(e));
    }
    menus.clear();
    menus.addAll(getMenu(0, rmenus));
    setState(() {});
  }

  List<MenuModal> getMenu(int pid, List<RawMenuModal> rmenus) {
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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff275C9D),
      child: menus.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: ListView.builder(
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      final data = menus[index];
                      return InkWell(
                        onTap: () {
                          for (var d in menus) {
                            d.isSelected = false;
                          }
                          data.isSelected = true;
                          // data.clickIndex = index;
                          cIndex = data.resourceId;
                          setState(() {});
                        },
                        child: Container(
                          color: data.isSelected ? Colors.white : null,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomMaterialIcon(
                                data.resourceIcon,
                                color: data.isSelected
                                    ? Colors.black
                                    : const Color(0xffBDE2EE),
                              ),
                              const SizedBox(
                                height: 8,
                              ), // Add some spacing between the icon and the text
                              Center(
                                child: Text(
                                  data.resourceName,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: data.isSelected
                                        ? Colors.black
                                        : const Color(0xffBDE2EE),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                cIndex != -1 ? childSideBar(cIndex) : Container(),
              ],
            ),
    );
  }

  Widget childSideBar(int cIndex) {
    List<MenuModal> childrens = menus.where((e) {
      if (e.resourceId == cIndex && e.children.isNotEmpty) {
        return true;
      }
      return false;
    }).toList();

    if (cIndex == -1 || childrens.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: 220,
      child: ListView.builder(
        itemCount: childrens.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CustomMaterialIcon(
              childrens[index].resourceIcon,
              color: const Color(0xffBDE2EE),
            ),
            title: Text(
              childrens[index].resourceName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xffBDE2EE), fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
