import 'package:erp_dev/pages/home/widgets/menu/controller.dart';
import 'package:erp_dev/pages/home/widgets/menu/modal.dart';
import 'package:erp_dev/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuView extends GetView<HomeMenuController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeMenuController>(builder: (controller) {
      return Material(
        color: const Color(0xff275C9D),
        child: controller.menus.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 80),
                    child: ListView.builder(
                      itemCount: controller.menus.length,
                      itemBuilder: (context, index) {
                        final data = controller.menus[index];
                        return InkWell(
                          // onTap: () {},
                          onTap: () {
                            for (var d in controller.menus) {
                              d.isSelected = false;
                            }
                            data.isSelected = true;
                            // data.clickIndex = index;
                            controller.cIndex = index;

                            Navigator.pushNamed(context, data.route);

                            controller.update();
                          },
                          child: Container(
                            color: data.isSelected
                                ? const Color(0xffBDE2EE)
                                : null,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomMaterialIcon(
                                  data.resourceIcon,
                                  color: data.isSelected
                                      ? const Color(0xff275C9D)
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
                                          ? const Color(0xff275C9D)
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
                  // controller.cIndex != -1 ? childSideBar(controller.cIndex) : Container(),
                ],
              ),
      );
    });
  }
}

Widget childSideMenu() {
  final HomeMenuController controller = Get.find();

  if (controller.cIndex == -1 ||
      controller.menus[controller.cIndex].children.isEmpty) {
    return const SizedBox.shrink();
  }
  List<MenuModal> l2 = controller.menus[controller.cIndex].children;
  List<List<MenuModal>> l3 = [];
  for (MenuModal i in l2) {
    l3.add(i.children);
  }
  return Material(
    child: MouseRegion(
      onExit: (event) {
        controller.menus[controller.cIndex].isSelected = false;
        controller.cIndex = -1;
        controller.selected = -1;
        controller.update();
      },
      child: Container(
        width: 220,
        color: const Color(0xff275C9D),
        child: ListView.builder(
          key: Key('builder ${controller.selected.toString()}'),
          itemCount: l2.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              key: Key(index.toString()),
              initiallyExpanded: index == controller.selected,
              iconColor: const Color(0xffBDE2EE),
              collapsedIconColor: const Color(0xffBDE2EE),
              backgroundColor: const Color.fromARGB(255, 71, 128, 199),
              leading: CustomMaterialIcon(
                l2[index].resourceIcon,
                color: const Color(0xffBDE2EE),
              ),
              title: Text(
                l2[index].resourceName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xffBDE2EE), fontSize: 12),
              ),

              onExpansionChanged: ((newState) {
                if (newState) {
                  controller.selected = index;
                  controller.update();
                } else {
                  controller.selected = -1;
                  controller.update();
                }
              }),
              // initiallyExpanded: expandedTileKey == index,

              children: l3[index].map((data) {
                return ListTile(
                  title: Text(
                    data.resourceName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xffBDE2EE), fontSize: 10),
                  ),
                  leading: CustomMaterialIcon(
                    data.resourceIcon,
                    color: const Color(0xffBDE2EE),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    ),
  );
}
