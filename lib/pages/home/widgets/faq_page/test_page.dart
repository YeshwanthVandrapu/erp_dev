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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff8f9fb),
        appBar: AppBar(
          title: const Text("Faq"),
          backgroundColor: const Color.fromARGB(255, 194, 197, 201),
        ),
        body: Row(
          children: <Widget>[
            GetBuilder<HomeMenuController>(builder: (controller) {
              return Expanded(
                child: Stack(children: [
                  const Responsive(children: [
                    Div(
                      divison: Division(
                          colL: 10,
                          offsetXL: 1,
                          offsetL: 1,
                          offsetM: 1,
                          offsetS: 1),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Faq(),
                      ),
                    )
                  ]),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: childSideMenu(),
                  )
                ]),
              );
            }),
          ],
        ),
      ),
    );
  }
}
