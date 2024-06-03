class StudentBuddy {
  final String image;
  final String name;
  final String branch;
  final String mail;

  StudentBuddy({
    required this.image,
    required this.name,
    required this.branch,
    required this.mail,
  });

  factory StudentBuddy.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "image": String image,
        "name": String name,
        "branch": String branch,
        "mail": String mail
      } =>
        StudentBuddy(
          image: image,
          name: name,
          branch: branch,
          mail: mail,
        ),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}
