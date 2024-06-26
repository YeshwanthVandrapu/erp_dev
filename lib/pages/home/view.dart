import 'package:erp_dev/pages/home/widgets/calendar/view.dart';
import 'package:erp_dev/pages/home/widgets/faq_page/view.dart';
import 'package:erp_dev/pages/home/widgets/home_quick_links/view.dart';
import 'package:erp_dev/pages/home/widgets/home_schedule/view.dart';
import 'package:erp_dev/pages/home/widgets/welcome_card/controller.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../utils/icons.dart';
import 'widgets/home_student_buddy/view.dart';
import 'widgets/upcoming_events/view.dart';
import 'widgets/welcome_card/welcome_widget.dart';

class NewHomeBody extends StatefulWidget {
  const NewHomeBody({super.key});

  @override
  State<NewHomeBody> createState() => _NewHomeBodyState();
}

class _NewHomeBodyState extends State<NewHomeBody> {
  @override
  void initState() {
    super.initState();
    loadJsonAsset();
    showDialogIfFirstLoaded();
  }

  final List<Map<String, dynamic>> jsonData = [];
  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('res/json/menu.json');
    var data = jsonDecode(jsonString);
    jsonData.clear();
    for (var e in data) {
      jsonData.add(e);
    }
    setState(() {});
    // dPrint(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;

    //showDialogIfFirstLoaded(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: "Dashboard  ",
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            WidgetSpan(
              child: Icon(Icons.settings_suggest_outlined),
            ),
          ]),
        ),
        actions: sWidth < 400
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 5),
                        Text(
                          'Search',
                          // style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
      ),
      drawer: sWidth <= 600
          ? Drawer(
              backgroundColor: const Color(0xff275C9D),
              // clipBehavior: ,
              child: ListView(
                children: jsonData.isEmpty
                    ? [const CircularProgressIndicator()]
                    : jsonData.map((data) {
                        return ListTile(
                          //style:
                          title: Text(
                            data['menu'] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Color(0xffBDE2EE)),
                          ),
                          leading: CustomMaterialIcon(
                            data['icons'] ?? "",
                            color: const Color(0xffBDE2EE),
                          ),
                        );
                      }).toList(),
              ),
            )
          : null,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1600),
          child: SingleChildScrollView(
            child: Responsive(
              alignment: WrapAlignment.center,
              // crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 24,
              children: <Widget>[
                Div(
                  divison: const Division(
                    colXL: 7,
                    colL: 10,
                    colM: 12,
                    // colXS: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      // margin: const EdgeInsets.only(top: 40, bottom: 40),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 226, 238),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                          maxHeight: sWidth > 540 ? 300 : 350, minHeight: 144),
                      child: const WelcomeCard(),
                    ),
                  ),
                ),
                Div(
                  divison: const Division(
                    colXL: 4,
                    colL: 10,
                    colM: 12,
                    // colXS: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      // margin: const EdgeInsets.only(bottom: 40),
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: const QuickLinks(),
                    ),
                  ),
                ),
                Div(
                  divison: const Division(colXL: 4, colL: 5, colM: 12),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: Get.width, maxHeight: 400),
                    child: const CustomCarousel(),
                  ),
                ),
                const Div(
                    divison: Division(colXL: 3, colL: 5, colM: 12),
                    child: UpcomingSchedule()),
                const SizedBox(
                  height: 40,
                ),
                const Div(
                  divison: Division(
                    colXL: 4,
                    colL: 10,
                    colM: 12,
                  ),
                  child: StudentBuddiesCard(),
                ),
                // Div(
                //   divison: const Division(colXL: 3, colL: 5, colM: 12),
                //   child: Container(
                //       constraints: const BoxConstraints(maxHeight: 300),
                //       child: const TaskListCard()),
                // ),
                Div(
                  divison: const Division(colXL: 4, colL: 6, colM: 12),
                  child: Container(
                      constraints:
                          const BoxConstraints(maxHeight: 500, maxWidth: 500),
                      child: const CalenderCard()),
                ),
                const Div(
                  divison: Division(colL: 10),
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Faq(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogIfFirstLoaded() async {
    var box = Hive.box('preferences');
    String firstLoadedKey = 'isFirstLoaded';
    // box.put(firstLoadedKey, true);
    await Future.delayed(const Duration(seconds: 1));
    if (box.get(firstLoadedKey) ?? false) {
      box.put(firstLoadedKey, false);
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 750,
              height: 600,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: SizedBox(
                        height: 360,
                        child: Image.asset(
                          "res/images/homepagePopup.png",
                          height: 672,
                          width: 1344,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // const Image(image: AssetImage("res/images/homepagePopup.png")),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GetBuilder<UserController>(builder: (controller) {
                        return Column(
                          children: [
                            Text(
                              "${"Welcome, ${controller.user!.name}"}👋",
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1)
                                  .copyWith(
                                      color: Colors.black,
                                      fontFamily:
                                          GoogleFonts.urbanist().fontFamily,
                                      decoration: TextDecoration.none),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Dear Student,"),
                                const Text(
                                    "As we gear up to welcome you on campus, we need your support in ensuring a seamless transition for your enrollment as a Krea Student. We require all the information collected in this form to initiate your registration as a bonafide student of the University. Please furnish all the requested information correctly and fill all the sections to the best of your knowledge."),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text("Important Note: "),
                                const Text(
                                    "(1) Providing incorrect information intentionally or deliberately withholding the requested information from the University can result in the cancellation/suspension of your enrolment status as a student of the University"),
                                const Text(
                                    "(2) To ensure smooth and easy submission, please use this form on a laptop or desktop computer."),
                                Text.rich(TextSpan(children: [
                                  const TextSpan(
                                      text:
                                          "(3) The last deadline to update all the requested information is  "),
                                  TextSpan(
                                      text: controller.user!.date,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]))
                              ],
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(255, 39, 92, 157),
                  ),
                ),
                child: const Text(
                  "I understand",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
