import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class UpcomingEventsCard extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String timing;
  final String header;
  final String title;
  final String description;
  final List viewers;
  final String venue;

  const UpcomingEventsCard({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.timing,
    required this.header,
    required this.title,
    required this.description,
    required this.viewers,
    required this.venue,
  });

  String formatListWithAnd(List<dynamic> viewers) {
    if (viewers.isEmpty) {
      return '';
    } else if (viewers.length == 1) {
      return viewers[0];
    } else if (viewers.length == 2) {
      return '${viewers[0]} and ${viewers[1]}';
    } else {
      String result = viewers.sublist(0, viewers.length - 1).join(', ');
      result += ' and ${viewers.last}';
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE2E2EA)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Responsive(
        runSpacing: 10,
        children: [
          Div(
            divison: const Division(colL: 4, colM: 4),
            child: SizedBox(
              width: 147,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                // height: double.infinity,
              ),
            ),
          ),
          Div(
            divison: const Division(colL: 5, colM: 5),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    header,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Start Date',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 0.15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "$date, $timing",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 0.15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    venue,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 0.15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.group,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        formatListWithAnd(viewers),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 0.15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
