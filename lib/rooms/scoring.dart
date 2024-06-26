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

int customScore(Map<String, dynamic> student1, Map<String, dynamic> student2) {
  int score = 0;

  if (student1['batch'] != student2['batch']) {
    score -= 50;
  }
  if (student1['program'] != student2['program']) {
    score -= 50;
  }
  if (student1['city'] == student2['city']) {
    score -= 20;
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
    score += preferenceScore(encodedPrefs[student1[param]]!,
        encodedPrefs[student2[param]]!, priority[param]!);
  }

  return score;
}
