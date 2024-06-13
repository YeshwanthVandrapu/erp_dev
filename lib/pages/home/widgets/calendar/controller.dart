import 'package:erp_dev/pages/home/widgets/calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  DateTime focusedDay = DateTime.now().add(const Duration(days: 2));
  DateTime? selectedDay;
  DateTime today = DateTime.now();
  TextEditingController eventController = TextEditingController();
  List<Event> selectedEvents = [];

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
    return kEvents[day] ?? [];
  }
}
