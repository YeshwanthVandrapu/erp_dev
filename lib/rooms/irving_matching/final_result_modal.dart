import 'dart:convert';

List<Test> testFromJson(String str) =>
    List<Test>.from(json.decode(str).map((x) => Test.fromJson(x)));

class Test {
  String school;
  String student1;
  String student1Sex;
  String student2;
  String student2Sex;
  int score;
  int score1;
  int score2;

  Test({
    required this.school,
    required this.student1,
    required this.student1Sex,
    required this.student2,
    required this.student2Sex,
    required this.score,
    required this.score1,
    required this.score2,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        school: json["school"],
        student1: json["student1"],
        student1Sex: json["student1_sex"],
        student2: json["student2"],
        student2Sex: json["student2_sex"],
        score: json["score"],
        score1: json["score_1"],
        score2: json["score_2"],
      );
}
