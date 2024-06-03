import 'dart:convert';

List<EventModal> eventModalFromJson(String str) =>
    List<EventModal>.from(json.decode(str).map((x) => EventModal.fromJson(x)));

class EventModal {
  String title;
  String day;
  String timing;
  String venue;
  String header;
  String description;
  List<String> viewers;
  String image;

  EventModal({
    required this.title,
    required this.day,
    required this.timing,
    required this.venue,
    required this.header,
    required this.description,
    required this.viewers,
    required this.image,
  });

  factory EventModal.fromJson(Map<String, dynamic> json) => EventModal(
        title: json["title"],
        day: json["day"],
        timing: json["timing"],
        venue: json["venue"],
        header: json["header"],
        description: json["description"],
        viewers: List<String>.from(json["viewers"].map((x) => x)),
        image: json["image"],
      );
}
