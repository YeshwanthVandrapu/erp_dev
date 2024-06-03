import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'student_buddy_card.dart';

class StudentBuddiesCard extends StatelessWidget {
  const StudentBuddiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constrain) {
        if (sWidth > 600) {
          return Column(
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
              const Row(
                children: [
                  Expanded(
                    child: StudentCard(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: StudentCard(),
                  ),
                ],
              ),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: const StudentCard(),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      // maxWidth: sWidth > 400 ? 400 : sWidth * 0.9,
                    ),
                    child: const StudentCard(),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
