import 'dart:convert';

import 'package:erp_dev/utils/print.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'modals.dart';

void split() async {
  List<Roommate> roommates = [];
  String jsonString =
      await rootBundle.loadString("res/json/roommate_student_list.json");
  for (Map<String, dynamic> i in jsonDecode(jsonString)) {
    roommates.add(Roommate.fromJson(i));
  }
  List<Rooms> rooms = [];
  String jsonStringRooms = await rootBundle.loadString("res/json/rooms.json");
  for (Map<String, dynamic> i in jsonDecode(jsonStringRooms)) {
    rooms.add(Rooms.fromJson(i));
  }

  Map<String, Map<String, List<Roommate>>> roommatesBySchoolAndSex = {};
  for (var roommate in roommates) {
    if (!roommatesBySchoolAndSex.containsKey(roommate.school)) {
      roommatesBySchoolAndSex[roommate.school] = {
        'Male': [],
        'Female': [],
        'Other': [],
      };
    }
    roommatesBySchoolAndSex[roommate.school]![roommate.sex]!.add(roommate);
  }
  matchAll(roommatesBySchoolAndSex, rooms);
}

final Map<String, int> encodedPrefs = {
  "Cold": 1,
  "Moderate": 2,
  "Doesn't matter": 3,
  "Warm": 4,
  "Clean": 1,
  "Early to bed": 1,
  "Normal (10pm)": 2,
  "Late to bed": 4,
  "Yes": 1,
  "No": 4,
  "Silent": 1,
  "Noisy": 4,
  "OK": 1,
  "Not OK": 4
};

int preferenceScore(int givenPref, int checkPref, int paramPriority) {
  final List<List<int>> pref1 = [
    [1, 1],
    [2, 2],
    [3, 3],
    [4, 4]
  ];

  final List<List<int>> pref2 = [
    [1, 3],
    [2, 3],
    [4, 3],
    [3, 1],
    [3, 2],
    [3, 4]
  ];

  if (pref1.any((pair) => pair[0] == givenPref && pair[1] == checkPref)) {
    return (100 / paramPriority).ceil();
  } else if (pref2
      .any((pair) => pair[0] == givenPref && pair[1] == checkPref)) {
    return (75 / paramPriority).ceil();
  } else {
    return (-200 / paramPriority).ceil();
  }
}

double customScore(Roommate student1, Roommate student2) {
  double score = 0;

  if (student1.batch != student2.batch) {
    score -= 500;
  }
  if (student1.program != student2.program) {
    score -= 350;
  }
  if (student1.city == student2.city) {
    score -= 200;
    if (student1.prevSchool == student2.prevSchool) {
      score -= 150;
    } else {
      score += 100;
    }
  }

  final Map<String, int> priority = {
    'temp': 1,
    'clean': 2,
    'bedtime': 3,
    'lights_on': 4,
    'noise': 5,
    'guests': 6
  };

  final List<String> params = [
    'temp',
    'clean',
    'bedtime',
    'lights_on',
    'noise',
    'guests'
  ];

  for (String param in params) {
    score += preferenceScore(encodedPrefs[student1.getProperty(param)]!,
        encodedPrefs[student2.getProperty(param)]!, priority[param]!);
  }

  return score;
}

List<List<Roommate?>> matchRoommates1(List<Roommate> roommates) {
  List<List<Roommate?>> matches = [];
  Set<int> matchedRoommates = {};

  for (int i = 0; i < roommates.length; i++) {
    if (matchedRoommates.contains(i)) {
      continue;
    }

    Roommate roommate1 = roommates[i];
    int? bestMatch;
    double bestScore = double.negativeInfinity;

    for (int j = 0; j < roommates.length; j++) {
      if (i == j || matchedRoommates.contains(j)) {
        continue;
      }

      Roommate roommate2 = roommates[j];
      double score = customScore(roommate1, roommate2);

      if (score > bestScore) {
        bestScore = score;
        bestMatch = j;
      }
    }

    if (bestMatch != null) {
      matches.add([roommate1, roommates[bestMatch]]);
      matchedRoommates.add(i);
      matchedRoommates.add(bestMatch);
    }
  }

  // Check if there's one unmatched Roommate remaining
  List<int> unmatched = [];
  for (int i = 0; i < roommates.length; i++) {
    if (!matchedRoommates.contains(i)) {
      unmatched.add(i);
    }
  }
  if (unmatched.isNotEmpty) {
    matches.add([roommates[unmatched[0]], null]);
  }

  return matches;
}

List<Map<String, dynamic>> assignRooms(
    List<Rooms> rooms, List<List<Roommate?>> matches) {
  List<Rooms> roomsCopy = List.from(rooms);
  List<Map<String, dynamic>> finalRooms = [];

  for (var match in matches) {
    for (var room in roomsCopy) {
      if (match[0]!.sex == room.category && match[0]!.school == room.school) {
        Student student =
            Student(student1: match[0]!.id, student2: match[1]?.id);

        // Create PairedStudents object
        PairedStudents pairedStudents = PairedStudents(
          roomNumber: room.roomNumber,
          students: [student.student1, student.student2],
        );

        // Convert PairedStudents object to JSON and add to finalRooms
        finalRooms.add(pairedStudents.toJson());

        // Remove room from roomsCopy
        roomsCopy.remove(room);
        break;
      }
    }
  }
  dPrint(finalRooms);

  return finalRooms;
}

List<dynamic> matchAll(
    Map<String, Map<String, List<Roommate>>> roommates, List<Rooms> rooms) {
  var allMatches = [];
  var assignedRooms = [];

  List<String> schoolKeys = ["SIAS", "IFMR", "GSB"];
  List<String> sexKeys = ["Male", "Female", "Other"];
  for (String key1 in schoolKeys) {
    for (String key2 in sexKeys) {
      allMatches.add(matchRoommates1(roommates[key1]![key2]!));
      assignedRooms
          .add(assignRooms(rooms, matchRoommates1(roommates[key1]![key2]!)));
    }
  }
  List<dynamic> flattenedList = assignedRooms.expand((list) => list).toList();
  dPrint(flattenedList[1]);
  return allMatches;
}

Future<List<dynamic>> makeGetRequest(String filePath) async {
  // Encode the file path
  String encodedPath = Uri.encodeComponent(filePath);

  // Make the GET request
  final response = await http.get(
    Uri.parse('http://127.0.0.1:5000/$encodedPath'),
  );

  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    if (decodedResponse.containsKey('Result') &&
        decodedResponse['Result'].isNotEmpty) {
      List<dynamic> pairings = decodedResponse["Result"];

      for (var pairing in pairings) {
        print(
            "For school: ${pairing["school"]} and sex: ${pairing["sex"]}, these are the matches: ");
        pairing["matches"].forEach((key, value) {
          print('$key is paired with $value');
        });
      }
      return pairings;
    }
  } else {
    print('GET request failed with status: ${response.statusCode}');
  }
  return [];
}
