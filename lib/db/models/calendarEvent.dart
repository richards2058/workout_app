
class calendarEvent{
  final int? id;
  final String dateTime;
  final String workoutPacket;

  calendarEvent({
    this.id,
    required this.dateTime,
    required this.workoutPacket
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime' : dateTime,
      'workoutPacket': workoutPacket,
    };
  }

  factory calendarEvent.fromMap(Map<String, dynamic> json) => calendarEvent(
      id: json['id'],
      dateTime: json['dateTime'],
      workoutPacket: json['workoutPacket'],
  );
}