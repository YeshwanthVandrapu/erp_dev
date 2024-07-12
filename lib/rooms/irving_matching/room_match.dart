import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../modals.dart';

void splitNew() async {
  try {
    List<Roommate> roommates = await loadRoommates();
    Map<String, Map<String, List<Roommate>>> roommatesBySchoolAndSex =
        groupRoommatesBySchoolAndSex(roommates);
    List<List<Roommate?>> matches = matchAll(roommatesBySchoolAndSex);

    printMatches(matches);
  } catch (e) {
    print('Error: $e');
  }
}

Future<List<Roommate>> loadRoommates() async {
  String jsonString = await rootBundle.loadString("res/json/day_from_erp.json");
  List<dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map((data) => Roommate.fromJson(data)).toList();
}

Map<String, Map<String, List<Roommate>>> groupRoommatesBySchoolAndSex(
    List<Roommate> roommates) {
  Map<String, Map<String, List<Roommate>>> grouped = {};
  for (var roommate in roommates) {
    grouped.putIfAbsent(
        roommate.school, () => {'Male': [], 'Female': [], 'Other': []});
    grouped[roommate.school]![roommate.sex]!.add(roommate);
  }
  return grouped;
}

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

final Map<String, int> encodedPrefs = {
  // Room temperature
  "colder": 1,
  "moderate": 2,
  "doesnt_matter": 3,
  "warmer": 4,
  // Cleanliness
//   select 'Very Orderly- I keep my clothes and things neatly arranged. I prefer to keep belongings off the floor' as dis, 'orderly' as opt
// union
// select 'Somewhat Orderly- I don''t mind clutter, but don''t like dirt' as dis, 'somewhat_orderly' as opt
// union
// select 'Somewhat Disorderly- I only clean when people come over' as dis, 'somewhat_disorderly' as opt
// union
// select 'Very Disorderly- I can''t see the floor of my room, and that''s alright.' as dis, 'very_disorderly' as opt
  "orderly": 1,
  "somewhat_orderly": 2,
  "somewhat_disorderly": 3,
  "very_disorderly": 4,
  // Bedtime
//   SELECT 'Early to bed (Before 10 PM)' dis , 'early' opt
// UNION
// SELECT 'Moderate timing (By 10 PM)' dis, 'moderate'opt
// UNION
// SELECT 'Late to bed (Midnight or later)' dis, 'late'opt
// UNION
// SELECT 'Doesn''t matter' dis, 'doesnt_matter' opt
  "early": 1,
  "late": 4,

// MUsic

// select 'Quiet is necessary. I need a silent environment to be productive.' as dis, 'quiet' as opt
// union all
// select 'I am okay with low levels of background noise (music, laptop).' as dis, 'moderate' as opt
// union all
// select 'I like to listen to loud music or other noise.' as dis, 'loud' as opt
// union all
// select 'I don''t really care if it''s loud or quiet in the room.' as dis, 'doesnt_matter' as opt
  "quiet": 1,
  "loud": 4,

  // Lights
//   SELECT 'I need complete darkness to sleep' AS dis, 'dark' AS opt
// UNION ALL
// SELECT 'A night light is okay' AS dis, 'night_light' AS opt
// UNION ALL
// SELECT 'I need a light to fall asleep' AS dis, 'normal_light' AS opt
// UNION ALL
// SELECT 'Doesn''t matter' AS dis, 'doesnt_matter' AS opt

  "night_light": 1,
  "dark": 2,
  "normal_light": 4,
  // Privacy
//   SELECT 'I like to keep my door open 24/7! The more the merrier.' AS dis,'open_247' AS opt
// UNION
// SELECT 'I will sometimes have one or two friends over, not large groups.' AS dis,'open_sometimes' AS opt
// UNION
// SELECT 'I prefer privacy in my room, and would rather gather in the common room to socialize.' AS dis,'privacy' AS opt
  "open_247": 3,
  "open_sometimes": 2,
  "privacy": 1
};

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
    'lightsOn': 4,
    'noise': 5,
    'guests': 6
  };

  final List<String> params = [
    'temp',
    'clean',
    'bedtime',
    'lightsOn',
    'noise',
    'guests'
  ];

  for (String param in params) {
    score += preferenceScore(
      encodedPrefs[student1.getProperty(param)]!,
      encodedPrefs[student2.getProperty(param)]!,
      priority[param]!,
    );
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
  return finalRooms;
}

List<List<Roommate?>> matchAll(
    Map<String, Map<String, List<Roommate>>> roommatesBySchoolAndSex) {
  List<List<Roommate?>> allMatches = [];
  List<String> sexKeys = ["Male", "Female", "Other"];

  for (String sex in sexKeys) {
    for (var roommates in roommatesBySchoolAndSex.values) {
      if (roommates.containsKey(sex)) {
        allMatches.addAll(matchRoommates1(roommates[sex]!));
      }
    }
  }

  return allMatches;
}

void printMatches(List<List<Roommate?>> matches) {
  for (var match in matches) {
    if (match[1] != null) {
      print("For school: ${match[0]!.school}");
      print(
          "${match[0]!.id} is paired with ${match[1]!.id} with a score of ${customScore(match[0]!, match[1]!)}");
    } else {
      print("For school: ${match[0]!.school}");
      print("${match[0]!.id} is unmatched");
    }
  }
  writeMatchesToJson(matches, 'res/json/matches.json');
}

void writeMatchesToJson(List<List<Roommate?>> matches, String filePath) {
  List<Map<String, dynamic>> jsonMatches = [];

  for (var match in matches) {
    if (match[1] != null) {
      jsonMatches.add({
        "school": match[0]!.school,
        "student1": match[0]!.id,
        "student1_sex": match[1]!.sex,
        "student2": match[1]!.id,
        "student2_sex": match[1]!.sex,
        "score": customScore(match[0]!, match[1]!),
        "score_1": customScore(match[0]!, match[1]!),
        "score_2": customScore(match[1]!, match[0]!),
      });
    } else {
      jsonMatches.add({
        "school": match[0]!.school,
        "student1": match[0]!.id,
        "student1_sex": match[0]!.sex,
        "student2": null,
        "student2_sex": null,
        "score": null,
        "score_1": null,
        "score_2": null,
      });
    }
  }

  String jsonString = jsonEncode(jsonMatches);

  // Write JSON data to a file
  File file = File(filePath);
  file.writeAsStringSync(jsonString);

  print('Matches written to $filePath');
}

Future<List<dynamic>> makeGetRequest(String filePath) async {
  String encodedPath = Uri.encodeComponent(filePath);

  try {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/$encodedPath'));

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
  } catch (e) {
    print('Error making GET request: $e');
  }
  return [];
}
