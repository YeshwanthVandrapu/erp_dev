import 'package:erp_dev/pages/home/widgets/menu/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/widgets/menu/controller.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Row(
        children: <Widget>[
          sWidth > 600 ? const MenuView() : const SizedBox.shrink(),
          GetBuilder<HomeMenuController>(builder: (controller) {
            return Expanded(
              child: Stack(children: [
                child,
                Align(
                  alignment: Alignment.centerLeft,
                  child: childSideMenu(),
                )
              ]),
            );
          }),
        ],
      ),
    );
  }
}
