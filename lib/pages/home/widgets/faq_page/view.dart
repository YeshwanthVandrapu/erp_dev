import 'package:erp_dev/pages/home/widgets/faq_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});
  // List<FaqItem> items = [
  //   FaqItem(category: "General"),
  //   FaqItem(category: "Personal Details"),
  //   FaqItem(category: "Academic Details"),
  //   FaqItem(category: "Contact Details"),
  //   FaqItem(category: "Health Information"),
  //   FaqItem(category: "Insurance Details"),
  //   FaqItem(category: "Undertaking and Consent Form"),
  //   FaqItem(category: "Preferences"),
  // ];

  @override
  Widget build(BuildContext context) {
    double catTextSize = 20;
    double sWidth = MediaQuery.of(context).size.width;
    return GetBuilder<FaqController>(builder: (controller) {
      if (controller.items.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Column(
          children: controller.items.map((item) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ExpansionTile(
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: Text(
                      item.category,
                      style: GoogleFonts.urbanist(
                        color: const Color(0xff275c9d),
                        fontWeight: FontWeight.w500,
                        fontSize: sWidth > 480 ? catTextSize : catTextSize - 4,
                      ),
                    ),
                    trailing: item.isExpanded
                        ? Icon(
                            Icons.remove,
                            color: const Color(0xff275c9d),
                            size: sWidth > 480 ? catTextSize + 4 : catTextSize,
                          )
                        : Icon(
                            Icons.add,
                            color: const Color(0xff275c9d),
                            size: sWidth > 480 ? catTextSize + 4 : catTextSize,
                          ),
                    onExpansionChanged: (bool expanded) {
                      item.isExpanded = !item.isExpanded;
                      controller.update();
                    },
                    children: item.questions.map((child) {
                      return ExpansionTile(
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: Text(
                          child.question,
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            fontSize: sWidth > 480
                                ? catTextSize - 2
                                : catTextSize - 6,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                child.answer,
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w300,
                                  fontSize: sWidth > 480
                                      ? catTextSize - 4
                                      : catTextSize - 8,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const Divider(
                  indent: 12,
                  endIndent: 12,
                ),
              ],
            );
          }).toList(),
        );
      }
    });
  }
}
