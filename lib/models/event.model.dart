class Event {
  final String name;
  final String description;
  final String room;

  Event({
    required this.name,
    required this.description,
    required this.room,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      description: json['description'],
      room: json['room'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'room': room,
    };
  }
}
