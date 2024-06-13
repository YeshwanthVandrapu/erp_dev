import 'package:erp_dev/pages/home/widgets/calendar/controller.dart';
import 'package:erp_dev/pages/home/widgets/calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

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
          // Build your dialog content here
          content: Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
            child: Column(
              children: [
                for (Event event in controller.selectedEvents)
                  Text(event.toString())
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CalendarController>(builder: (controller) {
        return Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: false,
              ),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: controller.selectedDay != controller.focusedDay
                      ? Colors.white
                      : const Color(0xff275C9D),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xff275C9D),

                  // borderRadius: BorderRadius.circular(10),
                ),
                todayDecoration: BoxDecoration(
                  color: const Color(0xff3C76BD),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              eventLoader: controller.getEventsForDay,
              focusedDay: controller.focusedDay,
              firstDay: DateTime.now().subtract((const Duration(days: 30))),
              lastDay: DateTime.now().add(const Duration(days: 365 * 4)),
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDay, day),
              onDaySelected: (DateTime selected, DateTime focused) {
                controller.onDaySelected(selected, focused);
                _showDialog(context, controller.selectedDay!);
              },
            ),
          ],
        );
      }),
    );
  }
}
