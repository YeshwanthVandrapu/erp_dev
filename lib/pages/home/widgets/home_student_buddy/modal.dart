class StudentBuddy {
  final String image;
  final String name;
  final String branch;
  final String mail;
  final String number;
  final String extension;

  StudentBuddy({
    required this.image,
    required this.name,
    required this.branch,
    required this.mail,
    required this.number,
    required this.extension,
  });

  factory StudentBuddy.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "image": String image,
        "name": String name,
        "branch": String branch,
        "mail": String mail,
        "number": String number,
        "extension": String extension
      } =>
        StudentBuddy(
            image: image,
            name: name,
            branch: branch,
            mail: mail,
            number: number,
            extension: extension),
      _ => throw const FormatException(
          "Failed to load card due to invalid format."),
    };
  }
}
