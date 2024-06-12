import 'dart:convert';

FaqModal faqModalFromJson(String str) => FaqModal.fromJson(json.decode(str));

class FaqModal {
  String category;
  bool isExpanded = false;
  List<Question> questions;

  FaqModal({
    required this.category,
    required this.questions,
  });

  factory FaqModal.fromJson(Map<String, dynamic> json) => FaqModal(
        category: json["category"],
        questions: json.containsKey("questions")
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : [],
      );
}

class Question {
  String question;
  String answer;

  Question({
    required this.question,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answer: json["answer"],
      );
}
