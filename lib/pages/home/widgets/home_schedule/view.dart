import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'modal.dart';

class UpcomingSchedule extends GetView<ScheduleController> {
  const UpcomingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      builder: (controller) => Stack(children: [
        controller.addingEvent
            ? AddScheduleItem()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "Upcoming Schedule",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "\n30-05-24",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.addingEvent = !controller.addingEvent;
                          controller.update();
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 500,
                      child: ListView(
                          children: controller.items
                              .map((item) => ScheduleItemCard(item: item))
                              .toList())),
                ],
              ),
      ]),
    );
  }
}

class ScheduleItemCard extends StatelessWidget {
  const ScheduleItemCard({super.key, required this.item});
  final ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      bottomStart: Radius.circular(10))),
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 12,
                            ),
                            Text(
                              item.date,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.access_time,
                              size: 12,
                            ),
                            Text(
                              item.time,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(item.description),
                    Row(
                      children: [const Icon(Icons.person), Text(item.name)],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddScheduleItem extends GetView<ScheduleController> {
  AddScheduleItem({super.key});
  final TextEditingController title = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController participants = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter the details of the event to be added",
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            controller: title,
            validator: (value) => GetUtils.isBlank(value ?? "") == true
                ? "Please fill this field"
                : null,
            decoration:
                const InputDecoration(hintText: "Enter the event title"),
          ),
          TextFormField(
              controller: date,
              validator: (value) => GetUtils.isBlank(value ?? "") == true
                  ? "Please fill this field"
                  : null,
              decoration: const InputDecoration(hintText: "Enter the date")),
          TextFormField(
              controller: time,
              validator: (value) => GetUtils.isBlank(value ?? "") == true
                  ? "Please fill this field"
                  : null,
              decoration: const InputDecoration(hintText: "Enter the time")),
          TextFormField(
              controller: description,
              validator: (value) => GetUtils.isBlank(value ?? "") == true
                  ? "Please fill this field"
                  : null,
              decoration:
                  const InputDecoration(hintText: "Enter a description")),
          TextFormField(
              controller: participants,
              validator: (value) => GetUtils.isBlank(value ?? "") == true
                  ? "Please fill this field"
                  : null,
              decoration: const InputDecoration(
                  hintText: "Enter the other participants")),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.items.add(ScheduleItem(
                      title: title.text,
                      date: date.text,
                      description: description.text,
                      name: participants.text,
                      time: time.text));
                  controller.addingEvent = !controller.addingEvent;
                  controller.update();
                  title.dispose();
                  date.dispose();
                  description.dispose();
                  participants.dispose();
                  time.dispose();
                }
              },
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 17, 67, 230))),
              child: const Text("Add Event"),
            ),
          )
        ],
      ),
    );
  }
}
