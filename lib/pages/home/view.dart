import 'package:erp_dev/utils/print.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../utils/icons.dart';
import 'widgets/home_schedule/view.dart';
import 'widgets/quick_links.dart';
import 'widgets/student_buddy_card.dart';
import 'widgets/welcome_widget.dart';

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
    dPrint(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    //showDialogIfFirstLoaded(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Responsive(
          // crossAxisAlignment = WrapCrossAlignment.start,
          runSpacing: 50,
          children: <Widget>[
            Div(
              divison: const Division(
                colXL: 6,
                colL: 10,
                colXS: 10,
                offsetXL: 1,
                offsetL: 1,
                offsetM: 1,
                offsetS: 1,
                offsetXS: 1,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 189, 226, 238),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints:
                        const BoxConstraints(maxHeight: 300, minHeight: 270),
                    child: const WelcomeCard(),
                  ),
                  // const Cardgrid(),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 40, bottom: 40),
                  //   decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 189, 226, 238),
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(width: 1, color: Colors.grey)),
                  //   constraints: const BoxConstraints(maxHeight: 300),
                  //   child: const TaskListCard(),
                  // ),

                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 400, maxHeight: 400),
                    child: const StudentCard(),
                  ),
                ],
              ),
            ),
            Div(
              divison: const Division(
                colXL: 3,
                colL: 10,
                colXS: 10,
                offsetXL: 1,
                offsetL: 1,
                offsetM: 1,
                offsetS: 1,
                offsetXS: 1,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    constraints:
                        const BoxConstraints(maxHeight: 300, maxWidth: 500),
                    child: const QuickLinks(),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 40, bottom: 40),
                  //   constraints:
                  //       const BoxConstraints(maxHeight: 500, maxWidth: 500),
                  //   child: const CalenderCard(),
                  // ),
                  const UpcomingSchedule(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) {
    //TODO add Hive for the pop up to only come the first time
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Column(
              children: [
                // Image.asset("/res/images/homepagePopup.png"),
                const Image(image: AssetImage("res/images/homepagePopup.png")),
                Text(
                  "Welcome, Wahiq Iqbal 👋",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1)
                      .copyWith(
                          color: Colors.black,
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          decoration: TextDecoration.none),
                ),
                const Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.")
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
            scrollable: true,
          );
        },
      );
    }
  }
}
