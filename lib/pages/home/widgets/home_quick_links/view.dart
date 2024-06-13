import 'package:erp_dev/pages/home/widgets/home_quick_links/controller.dart';
import 'package:erp_dev/pages/home/widgets/home_quick_links/modal.dart';
import 'package:erp_dev/utils/icons.dart';
import 'package:erp_dev/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickLinkController>(builder: (controller) {
      return Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Color(0xffe2e2ea),
              width: 1,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                constraints: const BoxConstraints(
                    minHeight: 60, minWidth: double.infinity),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Links",
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Divider(color: Color(0xff979797)),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.items
                        .map((item) => Ccard(item: item))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Ccard extends StatelessWidget {
  final QuickLink item;
  const Ccard({super.key, required this.item});

  showDialogue(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text("Redirecting you to ${item.link}"),
          actions: [
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 39, 92, 157)),
                )),
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(255, 39, 92, 157),
                  ),
                ),
                onPressed: () {
                  if (item.link.isNotEmpty) {
                    launchUrl(Uri.parse(item.link));
                    dPrint(item.text);
                  } else {
                    launchUrl(Uri.parse('https://krea.edu.in/'));
                  }
                  Get.back();
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          showDialogue(context);
        },
        child: Tooltip(
          message: item.text,
          verticalOffset: 40,
          child: Row(
            children: [
              Container(
                  constraints:
                      const BoxConstraints(maxHeight: 48, maxWidth: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff0095FF),
                  ),
                  child: Center(
                      child: CustomMaterialIcon(
                    item.icon,
                    color: Colors.white,
                  ))),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.urbanist(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      item.text,
                      style: GoogleFonts.urbanist(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff8F9BB3)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
