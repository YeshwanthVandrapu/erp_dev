import 'package:erp_dev/rooms/roommate.dart';

List<Map<String, dynamic>> assignRooms(
    List<Map<String, dynamic>> rooms, List<List<dynamic>> matches) {
  List<Map<String, dynamic>> roomsCopy = List.from(rooms);
  List<Map<String, dynamic>> finalRooms = [];

  for (var match in matches) {
    for (var room in roomsCopy) {
      if (match[0]['sex'] == room['Category'] &&
          match[0]['school'] == room['School']) {
        // Create Student objects for PairedStudents
        Student student1 = Student(student1: match[0]['id']);
        Student student2 =
            match[1] != null ? Student(student1: match[1]['id']) : Student();

        // Create PairedStudents object
        PairedStudents pairedStudents = PairedStudents(
          roomNumber: room['Room Number'].toString(),
          students: [student1, student2],
        );

        // Convert PairedStudents object to JSON and add to finalRooms
        finalRooms.add(pairedStudents.toJson());

        // Remove room from roomsCopy
        roomsCopy.remove(room);
        break;
      }
    }
  }

  return finalRooms;
}
