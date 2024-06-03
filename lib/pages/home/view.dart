import 'package:erp_dev/pages/home/widgets/home_quick_links/view.dart';
import 'package:erp_dev/utils/print.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../utils/icons.dart';
import 'widgets/home_student_buddy/view.dart';
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

                  // Container(
                  //   constraints:
                  //       const BoxConstraints(maxWidth: 400, maxHeight: 400),
                  //   child: const StudentCard(),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Div(
              divison: const Division(
                colXL: 4,
                colL: 10,
                colXS: 10,
                // offsetXL: 1,
                offsetL: 1,
                offsetM: 1,
                offsetS: 1,
                offsetXS: 1,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: const QuickLinks(),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 40, bottom: 40),
                  //   constraints:
                  //       const BoxConstraints(maxHeight: 500, maxWidth: 500),
                  //   child: const CalenderCard(),
                  // ),
                  // const UpcomingSchedule(),
                  const StudentBuddiesCard(),
                  // const Test(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
