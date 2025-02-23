class Node {
  final int id;
  final String name;
  final String width;
  final String height;

  Node({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'],
      name: json['name'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'width': width,
      'height': height,
    };
  }
}
