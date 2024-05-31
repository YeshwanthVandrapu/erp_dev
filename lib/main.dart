import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/view.dart';
import 'pages/home/widgets/home_schedule/controller.dart';
import 'pages/home/widgets/menu/view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ScheduleController());
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
          sWidth > 600 ? const MenuView() : Container(),
          const Expanded(
            flex: 5,
            child: NewHomeBody(),
          ),
        ],
      ),
    );
  }
}
