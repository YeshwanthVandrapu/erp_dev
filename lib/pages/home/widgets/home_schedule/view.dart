import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'controller.dart';
import 'modal.dart';

class UpcomingSchedule extends GetView<ScheduleController> {
  const UpcomingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormatter.format(now);
    // double sWidth = Get.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: Get.width),
            child: ListTile(
              trailing: IconButton(
                onPressed: () {
                  AddScheduleItemController addController =
                      Get.put(AddScheduleItemController());
                  final ScheduleController controller = Get.find();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: AddScheduleItem(),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // addController.dispose();
                                Get.back();
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white)),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 39, 92, 157)),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (addController.formKey.currentState!
                                    .validate()) {
                                  controller.addItemToList(
                                    ScheduleItem(
                                        title: addController.title.text,
                                        date: addController.selectedDate!,
                                        description:
                                            addController.description.text,
                                        name: addController.participants.text,
                                        time: addController.selectedTime!,
                                        colorCode: "0xffF34850"),
                                  );
                                  controller.update();
                                  // addController.dispose();
                                  Get.back();
                                }
                              },
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Color.fromARGB(255, 39, 92, 157))),
                              child: const Text(
                                "Add Event",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      }).then((_) {
                    // addController.title.text = '';
                    // addController.description.text = '';
                    // addController.participants.text = '';
                    // addController.dateTime.text = '';
                    // addController.selectedDateTime = null;
                    // addController.selectedDate = null;
                    // addController.selectedTime = null;
                    Get.delete<AddScheduleItemController>();
                  });
                },
                icon: const Icon(Icons.add),
              ),
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                "Upcoming Schedule",
                style: GoogleFonts.urbanist(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                formattedDate,
                style: GoogleFonts.urbanist(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff6c6c6c)),
              ),
            ),
          ),
          GetBuilder<ScheduleController>(builder: (controller) {
            return LayoutBuilder(builder: (context, constraints) {
              // List<Color> cardColors = [
              //   Colors.red,
              //   Colors.blue,
              //   const Color(0xff7F265B),
              // ];
              controller.sWidth = Get.width;
              return controller.sWidth > 1200
                  ? SizedBox(
                      height: 300,
                      child: ListView(
                          children: controller.items
                              .map((item) => ScheduleItemCard(
                                    item: item,
                                  ))
                              .toList()),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: controller.items
                          .map((item) => ScheduleItemCard(
                                item: item,
                              ))
                          .toList());
            });
          }),
        ],
      ),
    );
  }
}

class ScheduleItemCard extends StatelessWidget {
  const ScheduleItemCard({
    super.key,
    required this.item,
  });
  final ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width < 400 ? 180 : 140,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(int.parse(item.colorCode)),
                    borderRadius: const BorderRadiusDirectional.only(
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
                          Text(item.title,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(
                                    fontSizeFactor: 1.2,
                                  )
                                  .copyWith(fontWeight: FontWeight.w600)),
                          RichText(
                              text: TextSpan(
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 0.9)
                                      .copyWith(
                                        color: const Color(0xff6C6C6C),
                                      ),
                                  children: [
                                const WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Icon(Icons.calendar_month_outlined,
                                          color: Color(0xff6C6C6C)),
                                    )),
                                TextSpan(
                                  text: item.date,
                                ),
                                const WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                const WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.access_time,
                                          color: Color(0xff6C6C6C)),
                                    )),
                                TextSpan(
                                  text: item.time,
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
      ),
    );
  }
}

class AddScheduleItem extends StatelessWidget {
  AddScheduleItem({super.key});

  final AddScheduleItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the details of the event to be added",
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
            ),
            TextFormField(
              controller: controller.title,
              validator: (value) => GetUtils.isBlank(value ?? "") == true
                  ? "Please fill this field"
                  : null,
              decoration: const InputDecoration(
                hintText: "Enter the event title",
                // focusColor: Color.fromARGB(255, 39, 92, 157),
              ),
            ),
            TextFormField(
                controller: controller.description,
                validator: (value) => GetUtils.isBlank(value ?? "") == true
                    ? "Please fill this field"
                    : null,
                decoration:
                    const InputDecoration(hintText: "Enter a description")),
            TextFormField(
                controller: controller.participants,
                validator: (value) => GetUtils.isBlank(value ?? "") == true
                    ? "Please fill this field"
                    : null,
                decoration: const InputDecoration(
                    hintText: "Enter the other participants")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(
                //   controller.selectedDateTime == null
                //       ? "Pick a date and time"
                //       : "Selected date and time: ${controller.selectedDate}, ${controller.selectedTime}",
                //   overflow: TextOverflow.ellipsis,
                // ),
                Expanded(
                  child: TextFormField(
                    controller: controller.dateTime,
                    validator: (value) => GetUtils.isBlank(value ?? "") == true
                        ? "Please fill this field"
                        : null,
                    decoration: InputDecoration(
                      hintText: controller.selectedDateTime == null
                          ? "Pick a date and time"
                          : "Selected date and time: ${controller.selectedDate}, ${controller.selectedTime}",
                    ),
                    readOnly: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await controller.pickDateTime(context);
                    if (controller.selectedDateTime != null) {
                      controller.dateTime.text =
                          "${controller.selectedDate}, ${controller.selectedTime}";
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 39, 92, 157),
                    ),
                  ),
                  child: const Text(
                    "Pick",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
