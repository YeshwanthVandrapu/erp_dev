import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> linkData = [
      {
        'icon': Icons.school_outlined,
        'title': 'University Policies',
        'text': 'Access the universities official policies',
        'link': ''
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Life At Krea',
        'text': 'Embrace the life at Krea! Click here to know more.',
        'link': ''
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Krea Connect',
        'text': 'Answers to all your questions and queries at one place!',
        'link': ''
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Krea Connect',
        'text': 'Answers to all your questions and queries at one place!',
        'link': ''
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Krea Connect',
        'text': 'Answers to all your questions and queries at one place!',
        'link': ''
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Krea Connect',
        'text': 'Answers to all your questions and queries at one place!',
        'link': ''
      },
    ];

    return Card(
      color: Colors.white,
      elevation: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              constraints: const BoxConstraints(
                  minHeight: 60, minWidth: double.infinity),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff979797),
                    width: 3,
                  ),
                ),
              ),
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
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: linkData
                      .map((item) => customQuickLinkCard(item))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget customQuickLinkCard(Map<String, dynamic> item) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Tooltip(
      message: item['text'],
      verticalOffset: 40,
      child: Row(
        children: [
          Container(
              constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff0095FF),
              ),
              child: Center(
                  child: Icon(item['icon'], size: 24.0, color: Colors.white))),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.urbanist(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item['text'],
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
  );
}
