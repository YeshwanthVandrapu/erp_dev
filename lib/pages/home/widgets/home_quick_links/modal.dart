class QuickLink {
  final String icon;
  final String title;
  final String text;
  final String link;

  QuickLink({
    required this.icon,
    required this.title,
    required this.text,
    required this.link,
  });

  factory QuickLink.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "icon": String icon,
        "title": String title,
        "text": String text,
        "link": String link
      } =>
        QuickLink(icon: icon, title: title, text: text, link: link),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}
