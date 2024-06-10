import 'package:erp_dev/pages/home/widgets/menu/controller.dart';
import 'package:erp_dev/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuView extends GetView<HomeMenuController> {
  const MenuView({super.key});

  // final List<RawMenuModal> rmenus = [];
  // List<MenuModal> menus = [];
  // int cIndex = -1;

  // Future<void> loadJsonAsset() async {
  //   final String jsonString =
  //       await rootBundle.loadString('res/json/jsonformmatter.json');
  //   var data = jsonDecode(jsonString);
  //   rmenus.clear();
  //   for (var e in data) {
  //     rmenus.add(RawMenuModal.fromJson(e));
  //   }
  //   menus.clear();
  //   menus.addAll(getMenu("0", rmenus));
  //   setState(() {});
  // }

  // List<MenuModal> getMenu(String pid, List<RawMenuModal> rmenus) {
  //   List<MenuModal> menus = [];
  //   List<RawMenuModal> rmenuss = [];
  //   for (var rmenu in rmenus) {
  //     if (pid != rmenu.parentId) {
  //       rmenuss.add(rmenu);
  //     }
  //   }
  //   for (var rmenu in rmenus) {
  //     // rmenus.remove(rmenu);
  //     if (pid == rmenu.parentId) {
  //       menus.add(MenuModal(
  //           resourceIcon: rmenu.resourceIcon,
  //           resourceId: rmenu.resourceId,
  //           resourceName: rmenu.resourceName,
  //           children: getMenu(rmenu.resourceId, rmenuss)));
  //     }
  //   }
  //   return menus;
  // }

// 481216
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

  // Widget childSideBar(int cIndex) {
  //   if (cIndex == -1 || menus[cIndex].children.isEmpty) {
  //     return const SizedBox.shrink();
  //   }
  //   return Container(
  //     width: 220,
  //     color: const Color(0xff275C9D),
  //     child: ListView.builder(
  //       itemCount: menus[cIndex].children.length,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () {
  //             setState(() {
  //               for (var d in menus) {
  //                 d.isSelected = false;
  //               }
  //               menus[cIndex].children[index].isSelected = true;
  //               // data.clickIndex = index;
  //               cIndex = index;
  //             });
  //           },
  //           child: ExpansionTile(
  //             iconColor: const Color(0xffBDE2EE),
  //             collapsedIconColor: const Color(0xffBDE2EE),
  //             backgroundColor: const Color.fromARGB(255, 71, 128, 199),
  //             // enableFeedback: true,
  //             leading: CustomMaterialIcon(
  //               menus[cIndex].children[index].resourceIcon,
  //               color: menus[cIndex].children[index].isSelected
  //                   ? const Color.fromARGB(255, 71, 128, 199)
  //                   : const Color(0xffBDE2EE),
  //             ),
  //             title: Text(
  //               menus[cIndex].children[index].resourceName,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style: const TextStyle(color: Color(0xffBDE2EE), fontSize: 12),
  //             ),
  //             children: menus[cIndex].children[index].children.map((data) {
  //               return ListTile(
  //                 title: Text(
  //                   data.resourceName,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style:
  //                       const TextStyle(color: Color(0xffBDE2EE), fontSize: 10),
  //                 ),
  //                 leading: CustomMaterialIcon(
  //                   data.resourceIcon,
  //                   color: const Color(0xffBDE2EE),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}

Widget childSideMenu() {
  final HomeMenuController controller = Get.find();
  if (controller.cIndex == -1 ||
      controller.menus[controller.cIndex].children.isEmpty) {
    return const SizedBox.shrink();
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
          itemCount: controller.menus[controller.cIndex].children.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              // trailing: () {
              //   if (controller.menus[controller.cIndex].children[index]
              //       .children.isNotEmpty) {
              //     return const Icon(Icons.arrow_drop_down_outlined);
              //   } else {
              //     return const SizedBox.shrink();
              //   }
              // }(),
              key: Key(index.toString()),
              initiallyExpanded: index == controller.selected,
              iconColor: const Color(0xffBDE2EE),
              collapsedIconColor: const Color(0xffBDE2EE),
              backgroundColor: const Color.fromARGB(255, 71, 128, 199),
              // enableFeedback: true,
              leading: CustomMaterialIcon(
                controller
                    .menus[controller.cIndex].children[index].resourceIcon,
                color: controller
                        .menus[controller.cIndex].children[index].isSelected
                    ? const Color.fromARGB(255, 71, 128, 199)
                    : const Color(0xffBDE2EE),
              ),
              title: Text(
                controller
                    .menus[controller.cIndex].children[index].resourceName,
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

              children: controller
                  .menus[controller.cIndex].children[index].children
                  .map((data) {
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
