import 'dart:convert';

// Roommate Class

class Roommate {
  static const List<String> sexOptions = ['Male', 'Female', 'Other'];
  static const List<String> schoolOptions = ['SIAS', 'IFMR', 'GSB'];

  final String id;
  final String sex;
  final String school;
  final int batch;
  final String program;
  final String city;
  final String prevSchool;
  final String temp;
  final String clean;
  final String bedtime;
  final String lightsOn;
  final String noise;
  final String guests;

  Roommate({
    required this.id,
    required this.sex,
    required this.school,
    required this.batch,
    required this.program,
    required this.city,
    required this.prevSchool,
    required this.temp,
    required this.clean,
    required this.bedtime,
    required this.lightsOn,
    required this.noise,
    required this.guests,
  }) {
    if (!sexOptions.contains(sex)) {
      throw ArgumentError('sex must be one of $sexOptions');
    }
    if (!schoolOptions.contains(school)) {
      throw ArgumentError('school must be one of $schoolOptions');
    }
  }

  String getProperty(String property) {
    switch (property) {
      case 'temp':
        return temp;
      case 'clean':
        return clean;
      case 'bedtime':
        return bedtime;
      case 'lightsOn':
        return lightsOn;
      case 'noise':
        return noise;
      case 'guests':
        return guests;
      default:
        throw ArgumentError('Invalid property name: $property');
    }
  }

  @override
  String toString() {
    return 'Roommate(id: $id, sex: $sex, school: $school, batch: $batch, program: $program, city: $city, prev_school: $prevSchool, temp: $temp, clean: $clean, bedtime: $bedtime, lights_on: $lightsOn, noise: $noise, guests: $guests)';
  }

  factory Roommate.fromJson(Map<String, dynamic> json) {
    return Roommate(
      id: json["id"],
      sex: json["sex"],
      school: json["school"],
      batch: json["batch"],
      program: json["program"],
      city: json["city"] ?? "",
      prevSchool: json["prev_school"] ?? "",
      temp: json["temp"],
      clean: json["clean"],
      bedtime: json["bedtime"],
      lightsOn: json["lights_on"],
      noise: json["noise"],
      guests: json["guests"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'clean': clean,
      'bedtime': bedtime,
      'lightsOn': lightsOn,
      'noise': noise,
      'guests': guests,
    };
  }
}

// PairedStudents pairedStudentsFromJson(String str) =>
//     PairedStudents.fromJson(json.decode(str));

String pairedStudentsToJson(PairedStudents data) => json.encode(data.toJson());

class PairedStudents {
  String roomNumber;
  List<String?> students;

  PairedStudents({
    required this.roomNumber,
    required this.students,
  });

  // factory PairedStudents.fromJson(Map<String, dynamic> json) => PairedStudents(
  //       roomNumber: json["roomNumber"],
  //       students: List<Student>.from(
  //           json["students"].map((x) => Student.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        "roomNumber": roomNumber,
        "students": students,
      };
}

class Student {
  String? student1;
  String? student2;

  Student({
    this.student1,
    this.student2,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        student1: json["student1"],
        student2: json["student2"],
      );

  Map<String, String?> toJson() => {
        "student1": student1,
        "student2": student2,
      };
}

Rooms roomsFromJson(String str) => Rooms.fromJson(json.decode(str));

String roomsToJson(Rooms data) => json.encode(data.toJson());

class Rooms {
  String roomNumber;
  String category;
  String school;

  Rooms({
    required this.roomNumber,
    required this.category,
    required this.school,
  });

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
        roomNumber: json["Room Number"],
        category: json["Category"],
        school: json["School"],
      );

  Map<String, dynamic> toJson() => {
        "Room Number": roomNumber,
        "Category": category,
        "School": school,
      };
}
