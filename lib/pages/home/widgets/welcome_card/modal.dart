import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  String name;
  String email;
  String date;

  User({required this.name, required this.email, required this.date});

  // factory User.fromJson(Map<String, dynamic> json) => User(
  //       name: json["name"],
  //       email: json["email"],
  //     );

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"name": String name, "email": String email, "date": String date} =>
        User(name: name, email: email, date: date),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}
