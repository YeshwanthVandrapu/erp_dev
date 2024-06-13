import 'package:erp_dev/pages/home/widgets/faq_page/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../menu/controller.dart';
import '../menu/view.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Row(
        children: <Widget>[
          sWidth > 600 ? const MenuView() : const SizedBox.shrink(),
          GetBuilder<HomeMenuController>(builder: (controller) {
            return Expanded(
              child: Stack(children: [
                Scaffold(
                  appBar: AppBar(
                    title: const Text("AppBar"),
                  ),
                  body: const Responsive(children: [
                    Div(
                      divison: Division(colL: 10),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Faq(),
                      ),
                    )
                  ]),
                ),
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
