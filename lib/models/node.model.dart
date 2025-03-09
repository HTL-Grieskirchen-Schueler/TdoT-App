class Node {
  final int id;
  final String name;
  final String width;
  final String height;
  final int story;
  final List<int> neighbors;

  Node({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.story,
    required this.neighbors,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'],
      name: json['name'],
      width: json['width'],
      height: json['height'],
      story: json['story'],
      neighbors: json['neighbors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'width': width,
      'height': height,
      'story': story,
      'neighbors': neighbors,
    };
  }
}
