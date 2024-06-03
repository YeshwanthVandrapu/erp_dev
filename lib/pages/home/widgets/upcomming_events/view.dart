import 'dart:convert';

import 'package:erp_dev/pages/home/widgets/upcomming_events/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import '../../../../utils/print.dart';
import 'upcoming_events.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  // final EventController eventController = Get.put(EventController());
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final List<EventModal> events = [];

  Future<void> loadEvents() async {
    try {
      String response = await rootBundle.loadString("res/json/upevents.json");
      final data = await json.decode(response);
      events.clear();
      events.addAll(eventModalFromJson(json.encode(data)));
      setState(() {});
    } catch (e) {
      dPrint(e);
    }
  }

  Future<void> _startAutoSlide() async {
    await loadEvents();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < events.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  void _onPageChanged(int index) {
    _currentPage = index;
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: UpcomingEventsCard(
              imageUrl: event.image,
              date: event.day,
              timing: event.timing,
              header: event.header,
              title: event.title,
              description: event.description,
              viewers: event.viewers,
              venue: event.venue,
            ),
          );
        },
      );
    }
  }
}
