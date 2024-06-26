import 'package:erp_dev/pages/home/widgets/home_student_buddy/modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentCard extends StatelessWidget {
  final StudentBuddy item;
  const StudentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            color: Color(0xffe2e2ea),
            width: 1,
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                item.image,
                height: 92,
                width: 84,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xff081735),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Student',
              style: GoogleFonts.urbanist(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.school_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.branch,
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: item.mail,
                      );
                      if (await canLaunchUrl(emailLaunchUri)) {
                        await launchUrl(emailLaunchUri);
                      } else {
                        throw 'Could not launch email';
                      }
                    },
                    child: Tooltip(
                      message: item.mail,
                      child: Text(
                        item.mail,
                        style: GoogleFonts.urbanist(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                launchUrl(Uri.parse(
                    'https://wa.me/+${item.extension + item.number}?text=Hi'));
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // overlayColor: const WidgetStatePropertyAll(Colors.red),
              ),
              child: RichText(
                text: TextSpan(
                  text: "Say Hi!",
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
