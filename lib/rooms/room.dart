List<Map<String, dynamic>> assignRooms(
    List<Map<String, dynamic>> rooms, List<List<dynamic>> matches) {
  List<Map<String, dynamic>> roomsCopy = List.from(rooms);
  List<Map<String, dynamic>> finalRooms = [];

  for (var match in matches) {
    for (var room in roomsCopy) {
      if (match[0]['sex'] == room['Category'] &&
          match[0]['school'] == room['School']) {
        if (match[1] != null) {
          finalRooms.add({
            'Student1': match[0]['id'],
            'Student2': match[1]['id'],
            'RoomNumber': room['Room Number']
          });
        } else {
          finalRooms.add({
            'Student1': match[0]['id'],
            'Student2': '',
            'RoomNumber': room['Room Number']
          });
        }
        roomsCopy.remove(room);
        break;
      }
    }
  }

  return finalRooms;
}
