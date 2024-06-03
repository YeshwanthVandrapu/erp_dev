import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://s3-alpha-sig.figma.com/img/84b9/d56a/724f72eb2c73d3e7560e01a5f0093700?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GQSRtbWppcrV-K1VnMVpyizbsy4tL2KmWbI7aHzxwAi3bMgd826P1ACl6WV0D3PNNFdwUpnsOgEwWu8FupkezHmr-7CibmpfDt8IS2kz5U0NhiUcpGRsJmcaydWiQY0xCCXUPKdmgXfiM5z09ABSRIhRSod1LF03viyaOiVbT8WsQLgSn9Tq1ZUMAaRMj-RHZQzDU~fgNfpRL5EfHrcbSIJPJk3nzwIQWbOW6XzYg4V55fJUxffipdJLmf3EAsQ30TEGedMUzRM99E2hkLSW2i90KGnkulCf-wMmDDGZpvIGhPw-qJmRwtNJZaMLl9swtDezLeMSXQ0YQgBDOZ-5qw__',
                height: 92,
                width: 84,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Billie Rikhari',
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
                    'Psychology',
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
                  child: Text(
                    'sample.email.sias88@krea.ac.in',
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
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            Text(
              'Say Hi!',
              style: GoogleFonts.urbanist(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
