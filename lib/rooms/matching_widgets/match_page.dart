import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../pages/home/widgets/menu/controller.dart';
import 'test_table2.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff8f9fb),
        appBar: AppBar(
          title: const Text("Room Matching"),
          backgroundColor: const Color.fromARGB(255, 194, 197, 201),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: GetBuilder<HomeMenuController>(builder: (controller) {
              return const SingleChildScrollView(
                child: Responsive(children: [
                  Div(
                    divison: Division(
                      colL: 10,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Placeholder(),
                    ),
                  ),
                  Div(
                    divison: Division(
                      colL: 10,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: DataTableExample(),
                    ),
                  ),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
