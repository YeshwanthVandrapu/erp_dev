// Roommate Class
class Roommate {
  static const List<String> SEX_OPTIONS = ['Male', 'Female', 'Other'];
  static const List<String> SCHOOL_OPTIONS = ['SIAS', 'IFMR', 'GSB'];
  static const List<int> OPTIONS = [1, 2, 3];

  final String id;
  final String sex;
  final String school;
  final int batch;
  final String program;
  final String city;
  // final String prevSchool;
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
    // required this.prevSchool,
    required this.temp,
    required this.clean,
    required this.bedtime,
    required this.lightsOn,
    required this.noise,
    required this.guests,
  }) {
    if (!SEX_OPTIONS.contains(sex)) {
      throw ArgumentError('sex must be one of $SEX_OPTIONS');
    }
    if (!SCHOOL_OPTIONS.contains(school)) {
      throw ArgumentError('school must be one of $SCHOOL_OPTIONS');
    }
  }

  @override
  String toString() {
    return 'Roommate(id: $id, sex: $sex, school: $school, batch: $batch, program: $program, city: $city, prevSchool: prevSchool, temp: $temp, clean: $clean, bedtime: $bedtime, lightsOn: $lightsOn, noise: $noise, guests: $guests)';
  }

  factory Roommate.fromJson(Map<String, dynamic> json) {
    return Roommate(
      id: json["id"],
      sex: json["sex"],
      school: json["school"],
      batch: json["batch"],
      program: json["program"],
      city: json["city"],
      // prevSchool: json["prevSchool"],
      temp: json["temp"],
      clean: json["clean"],
      bedtime: json["bedtime"],
      lightsOn: json["lights_on"],
      noise: json["noise"],
      guests: json["guests"],
    );
  }
}
