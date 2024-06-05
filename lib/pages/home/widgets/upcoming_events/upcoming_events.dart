import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.fromLTRB(1, 0, 10, 0),
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
                divison: const Division(colL: 4, colM: 4, colS: 4, colXS: 4),
                // child: Placeholder()
                child: SizedBox(
                  // width: 147,
                  height: constraints.maxHeight,
                  // height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      height: 400,
                      imageUrl,
                      fit: BoxFit.fitHeight,
                      // height: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Div(
                divison: const Division(colL: 7, colM: 7, colS: 7, colXS: 7),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    constraints:
                        BoxConstraints(maxHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist',
                            // height: 0.09,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'Start Date',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Urbanist',
                                    // height: 0.15,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "$date, $timing",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Urbanist',
                                    // height: 0.15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  venue,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Urbanist',
                                    // height: 0.15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  header,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Div(
                                  child: Text(
                                    description + description,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: (constraints.maxWidth * 2 / 3) - 144 < 0
                                  ? 0
                                  : (constraints.maxWidth * 2 / 3) - 144,
                              // Width calculated by the following,
                              // Image width in card = 1/3, so remaining = 2/3
                              //SizedBox = 15 , Padding = 8, PageIndicator for switching = 120, so 120 + 15 + 8 = 143
                              // Remaining space should be occupied by the row

                              child: Tooltip(
                                message: formatListWithAnd(viewers),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.urbanist().fontFamily,
                                      ),
                                      children: [
                                        const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(Icons.group),
                                        ),
                                        const WidgetSpan(
                                            child: SizedBox(
                                          width: 8,
                                        )),
                                        TextSpan(
                                          text: formatListWithAnd(viewers),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            // height: 0.15,
                                          ),
                                        )
                                      ]),
                                ),
                              )
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     const Icon(
                              //       Icons.group,
                              //     ),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Tooltip(
                              //       message: formatListWithAnd(viewers),
                              //       child: Text(
                              //         formatListWithAnd(viewers),
                              //         overflow: TextOverflow.ellipsis,
                              //         maxLines: 1,
                              //         style: const TextStyle(
                              //           fontSize: 10,
                              //           fontWeight: FontWeight.w400,
                              //           color: Colors.black,
                              //           overflow: TextOverflow.ellipsis,
                              //           // height: 0.15,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
