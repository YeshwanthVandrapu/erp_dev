import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';
import 'modal.dart';

class UpcomingSchedule extends GetView<ScheduleController> {
  const UpcomingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return GetBuilder<ScheduleController>(
      builder: (controller) => Stack(children: [
        controller.addingEvent
            ? AddScheduleItem()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming Schedule",
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1.5),
                          ),
                          Text(formattedDate),
                        ],
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
        height: MediaQuery.of(context).size.width < 400 ? 180 : 140,
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
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 1.2),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(Icons.calendar_month_outlined)),
                          TextSpan(
                            text: item.date,
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 0.8),
                          ),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 10,
                          )),
                          const WidgetSpan(child: Icon(Icons.access_time)),
                          TextSpan(
                            text: item.time,
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 0.8),
                          ),
                        ]))
                      ],
                    ),
                    Text(
                      item.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
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
          Text(
            "Enter the details of the event to be added",
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
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
                      WidgetStatePropertyAll(Color.fromARGB(255, 39, 92, 157))),
              child: const Text(
                "Add Event",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
