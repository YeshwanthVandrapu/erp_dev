import 'package:erp_dev/pages/home/widgets/calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime today = DateTime.now();
  TextEditingController eventController = TextEditingController();
  List<Event> selectedEvents = [];
  int popUpCardSelected = -1;

  @override
  void onInit() {
    super.onInit();
    selectedDay = focusedDay;
  }

  void onDaySelected(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    selectedEvents = getEventsForDay(selectDay);
    update();
  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    // return kEvents[day] ?? [];
    return (kEvents[day] ?? []).map((event) {
      return Event(
        event.title,
        event.accessLocation,
        isOnDaySelected: isSameDay(day, selectedDay ?? DateTime.now()),
      );
    }).toList();
  }
}
