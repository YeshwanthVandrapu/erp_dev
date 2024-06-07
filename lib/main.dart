import 'package:erp_dev/pages/home/widgets/home_quick_links/controller.dart';
import 'package:erp_dev/pages/home/widgets/home_student_buddy/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'pages/home/view.dart';
import 'pages/home/widgets/home_schedule/controller.dart';
import 'pages/home/widgets/menu/view.dart';
import 'pages/home/widgets/welcome_card/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(StudentBuddyController());
  Get.put(ScheduleController());
  Get.put(QuickLinkController());
  await Hive.openBox('preferences', path: './');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Krea Erp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Row(
        children: <Widget>[
          sWidth > 600 ? const MenuView() : const SizedBox.shrink(),
          const Expanded(
            // flex: 5,
            child: NewHomeBody(),
          ),
        ],
      ),
    );
  }
}
