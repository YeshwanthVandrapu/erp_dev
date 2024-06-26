import 'roommate.dart';
import 'scoring.dart';

List<List<Roommate?>> matchRoommates1(List<Roommate> Roommates) {
  List<List<Roommate?>> matches = [];
  Set<int> matchedRoommates = {};

  for (int i = 0; i < Roommates.length; i++) {
    if (matchedRoommates.contains(i)) {
      continue;
    }

    Roommate Roommate1 = Roommates[i];
    int? bestMatch;
    double bestScore = double.negativeInfinity;

    for (int j = 0; j < Roommates.length; j++) {
      if (i == j || matchedRoommates.contains(j)) {
        continue;
      }

      Roommate Roommate2 = Roommates[j];
      double score = customScore(Roommate1, Roommate2);

      if (score > bestScore) {
        bestScore = score;
        bestMatch = j;
      }
    }

    if (bestMatch != null) {
      matches.add([Roommate1, Roommates[bestMatch]]);
      matchedRoommates.add(i);
      matchedRoommates.add(bestMatch);
    }
  }

  // Check if there's one unmatched Roommate remaining
  List<int> unmatched = [];
  for (int i = 0; i < Roommates.length; i++) {
    if (!matchedRoommates.contains(i)) {
      unmatched.add(i);
    }
  }
  if (unmatched.isNotEmpty) {
    matches.add([Roommates[unmatched[0]], null]);
  }

  return matches;
}
