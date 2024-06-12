class FaqItem {
  final String category;
  bool isExpanded;
  List<Questions> children = [
    Questions(
        question: "How do access the form?", answer: "this is the answer"),
    Questions(
        question: "What happens if I miss the deadline?",
        answer: "this is the answer"),
    Questions(
        question: "I cannot see the form on my Dashboard",
        answer: "this is the answer"),
  ];
  FaqItem({required this.category, this.isExpanded = false});
}

class Questions {
  final String question;
  final String answer;
  Questions({required this.question, required this.answer});
}
