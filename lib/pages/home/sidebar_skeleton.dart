import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class jsonCard {
  final int parent_id;
  final String resource_icon;
  final int resource_id;
  final String resource_name;

  const jsonCard({
    required this.parent_id,
    required this.resource_icon,
    required this.resource_id,
    required this.resource_name,
  });

  // jsonCard.fromJson(Map<String, dynamic> json) {
  //   this.parent_id = json["parent_id"];
  //   this.resource_icon = json["resource_icon"];
  //   this.resource_id = json["resource_id"];
  //   this.resource_name = json["resource_name"];
  // }
  factory jsonCard.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "parent_id": int parent_id,
        "resource_icon": String resource_icon,
        "resource_id": int resource_id,
        "resource_name": String resource_name,
      } =>
        jsonCard(
          parent_id: parent_id,
          resource_icon: resource_icon,
          resource_id: resource_id,
          resource_name: resource_name,
        ),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}

typedef IndexCallBack = void Function(int index);

// ignore: must_be_immutable
class jsonSidebarCard extends StatelessWidget {
  jsonSidebarCard({
    super.key,
    required this.jCard,
    required this.index,
    required this.onPressedSidebarCard,
  });

  final jsonCard jCard;
  final int index;
  final IndexCallBack onPressedSidebarCard;
  bool pressed = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 4, 85, 151),
      child: InkWell(
        onTap: () {
          pressed = !pressed;
          onPressedSidebarCard(index);
        },
        child: Column(
          children: [
            const Icon(
              Icons.star,
              color: Colors.lightBlue,
            ), //CHANGE THIS,
            const SizedBox(
              width: 10,
            ),
            Text(jCard.resource_name,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}

class jsonSidebar extends StatefulWidget {
  const jsonSidebar({
    super.key,
    required this.section,
  });
  final Widget section;

  @override
  State<jsonSidebar> createState() => _jsonSidebarState();
}

class _jsonSidebarState extends State<jsonSidebar> {
  List<jsonCard> l1Cards = [];
  List<jsonCard> allCards = [];
  final kreaLogo = File('resources/kreaLogo.png');
  int currentCardSelection = 0;
  bool maximizeSidebar = false;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void readJson() async {
    String rawJson = await File("resources/jsonformatter.txt").readAsString();
    List<jsonCard> l1 = [];
    List<jsonCard> all = [];
    for (Map<String, dynamic> i in jsonDecode(rawJson)) {
      all.add(jsonCard.fromJson(i));
    }
    for (jsonCard elem in all) {
      if (elem.parent_id == 0) {
        l1.add(elem);
      }
    }
    setState(
      () {
        l1Cards = l1;
        allCards = all;
      },
    );
  }

  void onPressedSidebarButton(int index) {
    setState(() {
      currentCardSelection = index;
    });
  }

  List<jsonCard> findChildren(jsonCard parent) {
    List<jsonCard> children = [];
    for (jsonCard child in allCards) {
      if (parent.resource_id == child.parent_id) {
        children.add(child);
      }
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 100,
            color: Colors.indigo,
            child: ListView(
              children: [
                Image.file(kreaLogo),
                for (int i = 0; i < l1Cards.length; i++)
                  jsonSidebarCard(
                    jCard: l1Cards[i],
                    index: i,
                    onPressedSidebarCard: onPressedSidebarButton,
                  ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: maximizeSidebar
                        ? Colors.white
                        : const Color.fromARGB(255, 4, 85, 151),
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          maximizeSidebar = !maximizeSidebar;
                        });
                      },
                      child: Column(children: [
                        const Icon(Icons.menu),
                        () {
                          if (maximizeSidebar) {
                            return const Text(
                              "Close",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 4, 85, 151)),
                            );
                          } else {
                            return const Text(
                              "Open",
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        }(),
                      ])),
                )
                //Text(
                // i.cardName,
                // style: const TextStyle(color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              body: Stack(children: [
                // INSERT welcome card etc.
                Column(
                  children: [
                    AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Dashboard"),
                          Container(
                            // Search box
                            width: 150,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                label: const Row(
                                  children: [
                                    Icon(Icons.search),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Search"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.refresh),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        // child: DashboardContents(
                        //   allCards: allCards,
                        //   l1Cards: l1Cards,
                        // ),
                        child: widget.section,
                      ),
                    ),
                  ],
                ),
                // Pop up sidebar,
                Align(
                  alignment: Alignment.centerLeft,
                  child: () {
                    if (maximizeSidebar &&
                        findChildren(l1Cards[currentCardSelection])
                            .isNotEmpty) {
                      return Container(
                        width: 150,
                        color: Colors.indigo,
                        child: ListView(
                          children: [
                            for (jsonCard l2
                                in findChildren(l1Cards[currentCardSelection]))
                              Text(
                                l2.resource_name,
                                style: const TextStyle(color: Colors.white),
                              )
                          ],
                        ),
                      );
                    }
                  }(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
