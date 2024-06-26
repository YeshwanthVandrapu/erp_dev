import 'package:erp_dev/pages/home/widgets/calendar/controller.dart';
import 'package:erp_dev/pages/home/widgets/calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/link.dart';

// Container(
//       margin: const EdgeInsets.only(top: 40, bottom: 40),
//       constraints:
//           const BoxConstraints(maxHeight: 500, maxWidth: 500),
//       child: const CalenderCard(),
//     ),

class CalenderCard extends GetView<CalendarController> {
  const CalenderCard({super.key});
  void _showDialog(BuildContext context, DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: GetBuilder<CalendarController>(builder: (controller) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 600, maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Events for ${DateFormat('dd MMMM yy').format(selectedDay)}",
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.5)
                          .copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff11142d),
                          )),
                  for (int i = 0; i < controller.selectedEvents.length; i++)
                    popUpCard(context, i),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.popUpCardSelected = -1;
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    ).then((_) {
      controller.popUpCardSelected = -1;
      controller.update();
    });
  }

  Widget popUpCard(BuildContext context, int index) {
    String formatDurationToEvent(Duration duration) {
      if (duration.inDays > 30) {
        return '${duration.inDays ~/ 30}m';
      } else if (duration.inDays > 7) {
        return '${duration.inDays ~/ 7}w';
      } else if (duration.inDays > 0) {
        return '${duration.inDays}d';
      } else if (duration.inHours > 0) {
        return '${duration.inHours}h';
      } else if (duration.inMinutes > 0) {
        return '${duration.inMinutes}min';
      } else {
        return 'Now';
      }
    }

    return GestureDetector(
      onTap: () {
        controller.popUpCardSelected = index;
        controller.update();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: controller.popUpCardSelected != index
              ? Colors.white
              : const Color(0xff3f8cff),
        ),
        // constraints: const BoxConstraints(
        //   maxHeight: 80,
        //   minHeight: 80,
        //   maxWidth: 344,
        //   minWidth: 344,
        // ),
        height: 80,
        width: 344,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.selectedEvents[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: controller.popUpCardSelected == index
                              ? Colors.white
                              : const Color(0xff081735)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    formatDurationToEvent(
                      controller.selectedDay!.difference(
                        DateTime.now(),
                      ),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: controller.popUpCardSelected == index
                          ? Colors.white
                          : const Color(0xff8f95b2),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "New event in",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 0.8)
                        .copyWith(
                            fontWeight: FontWeight.w600,
                            color: controller.popUpCardSelected == index
                                ? Colors.white
                                : const Color(0xff8f95b2)),
                  ),
                ),
                Link(
                  uri: Uri.parse("https://krea.edu.in/"),
                  builder: (BuildContext context, FollowLink? followLink) =>
                      GestureDetector(
                    onTap: followLink,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        controller.selectedEvents[index].accessLocation,
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 0.8)
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color: controller.popUpCardSelected == index
                                  ? Colors.white
                                  : const Color(0xff3f8cff),
                            ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CalendarController>(builder: (controller) {
        return Container(
          color: const Color(0xffF8F9FB),
          child: TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: false,
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, day, focusedDay) {
                return Center(
                  child: Container(
                    width: 32,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff275C9D),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            DateFormat('d').format(day),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < 3 &&
                                      i <
                                          controller
                                              .getEventsForDay(day)
                                              .length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 1.5,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 5,
                                    height: 5,
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                return Center(
                  child: Container(
                    width: 32,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff72A0D7),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            DateFormat('d').format(day),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < 3 &&
                                      i <
                                          controller
                                              .getEventsForDay(day)
                                              .length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 1.5,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 5,
                                    height: 5,
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                return Center(
                  child: Container(
                    width: 32,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            DateFormat('d').format(day),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < 3 &&
                                      i <
                                          controller
                                              .getEventsForDay(day)
                                              .length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 1.5,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff275C9D),
                                    ),
                                    width: 5,
                                    height: 5,
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              outsideBuilder: (context, day, focusedDay) {
                return Center(
                  child: Container(
                    width: 32,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            DateFormat('d').format(day),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 196, 196, 196)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < 3 &&
                                      i <
                                          controller
                                              .getEventsForDay(day)
                                              .length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 1.5,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff275C9D),
                                    ),
                                    width: 5,
                                    height: 5,
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              markerBuilder: (context, day, List<Event> events) {
                if (events.isEmpty) return const SizedBox.shrink();
                return const SizedBox.shrink();
              },
            ),
            eventLoader: controller.getEventsForDay,
            focusedDay: controller.focusedDay,
            firstDay: DateTime.now().subtract((const Duration(days: 30))),
            lastDay: DateTime.now().add(const Duration(days: 365 * 4)),
            selectedDayPredicate: (day) =>
                isSameDay(controller.selectedDay, day),
            onDaySelected: (DateTime selected, DateTime focused) {
              controller.onDaySelected(selected, focused);
              if (controller.selectedEvents.isNotEmpty) {
                _showDialog(context, controller.selectedDay!);
              }
            },
          ),
        );
      }),
    );
  }
}
