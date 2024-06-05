import 'dart:convert';
import 'package:erp_dev/pages/home/widgets/upcomming_events/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../../utils/print.dart';
import 'upcoming_events.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel>
    with TickerProviderStateMixin {
  // final EventController eventController = Get.put(EventController());
  final PageController _pageController = PageController();
  late TabController _tabController;
  Timer? _timer;
  // final int _currentPage = 0;
  int cp = 0;

  @override
  void initState() {
    super.initState();
    // _startAutoSlide();
    loadEvents();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  final List<EventModal> events = [];

  Future<void> loadEvents() async {
    try {
      String response = await rootBundle.loadString("res/json/upevents.json");
      final data = await json.decode(response);
      events.clear();
      events.addAll(eventModalFromJson(json.encode(data)));

      _tabController = TabController(length: events.length, vsync: this);
      setState(() {});
    } catch (e) {
      dPrint(e);
    }
  }

  // Future<void> _startAutoSlide() async {
  //   await loadEvents();
  //   _timer = Timer.periodic(const Duration(seconds: 0), (Timer timer) {
  //     if (_currentPage < events.length - 1) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      cp = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    if (events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 4),
              title: Text(
                "Upcoming Events",
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
            Container(
              constraints: const BoxConstraints(maxHeight: 100, maxWidth: 500),
              child: PageIndicator(
                currentPageIndex: cp,
                tabController: _tabController,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _handlePageViewChanged,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return UpcomingEventsCard(
                    imageUrl: event.image,
                    date: event.day,
                    timing: event.timing,
                    header: event.header,
                    title: event.title,
                    description: event.description,
                    viewers: event.viewers,
                    venue: event.venue,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                onUpdateCurrentPageIndex(tabController.length - 1);
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
            ),
          ),
          TabPageSelector(
            controller: tabController,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == tabController.length - 1) {
                onUpdateCurrentPageIndex(0);
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
