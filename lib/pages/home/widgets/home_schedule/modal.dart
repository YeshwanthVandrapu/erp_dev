class ScheduleItem {
  final String title;
  final String date;
  final String time;
  final String description;
  final String name;
  final String colorCode;

  const ScheduleItem({
    required this.title,
    required this.date,
    required this.description,
    required this.name,
    required this.time,
    required this.colorCode,
  });

  // jsonCard.fromJson(Map<String, dynamic> json) {
  //   this.parent_id = json["parent_id"];
  //   this.resource_icon = json["resource_icon"];
  //   this.resource_id = json["resource_id"];
  //   this.resource_name = json["resource_name"];
  // }
  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "title": String title,
        "date": String date,
        "time": String time,
        "description": String description,
        "name": String name,
        "colorCode": String colorCode,
      } =>
        ScheduleItem(
          title: title,
          date: date,
          time: time,
          description: description,
          name: name,
          colorCode: colorCode,
        ),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}
