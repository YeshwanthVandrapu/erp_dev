import 'package:erp_dev/pages/home/widgets/home_student_buddy/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';
import 'student_buddy_card.dart';

class StudentBuddiesCard extends StatelessWidget {
  const StudentBuddiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return GetBuilder<StudentBuddyController>(builder: (controller) {
      if (controller.items.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return LayoutBuilder(
          builder: (context, constrain) {
            if (sWidth > 400) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Your Student Buddies",
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Buddy Support: Your Go-To for All Queries",
                        style: GoogleFonts.urbanist(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff6c6c6c)),
                      ),
                    ),
                    Row(
                        children: controller.items.map((item) {
                      return Expanded(
                          child: StudentCard(
                        item: item,
                      ));
                    }).toList())
                  ],
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 12),
                  title: Text(
                    "Your Student Buddies",
                    style: GoogleFonts.urbanist(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Buddy Support: Your Go-To for All Queries",
                    style: GoogleFonts.urbanist(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff6c6c6c)),
                  ),
                ),
                for (StudentBuddy item in controller.items)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: StudentCard(
                          item: item,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      }
    });
  }
}
