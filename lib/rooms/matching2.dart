import 'roommate.dart';
import 'scoring.dart';

List<dynamic> matchAll(Map<String, Map<String, List<Roommate>>> roommates) {
  var allMatches = [];
  List<String> schoolKeys = ["SIAS", "IFMR", "GSB"];
  List<String> sexKeys = ["Male", "Female"];
  for (String key1 in schoolKeys) {
    for (String key2 in sexKeys) {
      allMatches.add(matchRoommates1(roommates[key1]![key2]!));
    }
  }
  print(allMatches[0][1]);
  return allMatches;
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
