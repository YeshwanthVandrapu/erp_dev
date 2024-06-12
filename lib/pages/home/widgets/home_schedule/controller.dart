import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'modal.dart';

class ScheduleController extends GetxController {
  List<ScheduleItem> items = [];
  double sWidth = 0;

  @override
  void onInit() async {
    super.onInit();
    items.clear();
    String rawJson = await rootBundle
        .loadString("res/json/homepage_upcoming_schedule_items.json");
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      items.add(ScheduleItem.fromJson(i));
    }
    update();
  }

  Future<void> addItemToList(ScheduleItem newItem) async {
    await Future.delayed(const Duration(seconds: 0));
    items.add(newItem);
  }
}

class AddScheduleItemController extends GetxController {
  DateTime? selectedDateTime;
  String? selectedDate;
  String? selectedTime;
  DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
  DateFormat timeFormatter = DateFormat('kk:mm');
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController participants = TextEditingController();
  final TextEditingController dateTime = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> pickDateTime(BuildContext context) async {
    DateTime? dateTime = await showDateTimePicker(context: context);
    if (dateTime != null) {
      selectedDateTime = dateTime;
      selectedDate = dateFormatter.format(selectedDateTime!);
      selectedTime = timeFormatter.format(selectedDateTime!);
      update();
    }
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate;
    lastDate ??= firstDate.add(const Duration(days: 365));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff044F80),
              onPrimary: Color(0xffA8A8A8),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff044F80),
              onPrimary: Color(0xff8E8E8E),
              secondary: Color(0xffA8A8A8),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  void showPopUp(context) {}
}
