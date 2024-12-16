class InformationParagraph {
  String text;
  String? heading;
  String? info;

  InformationParagraph({required this.text, this.heading, this.info});

  factory InformationParagraph.fromJson(Map<String, dynamic> json) {
    return InformationParagraph(
      text: json['text'],
      heading: json['heading'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'heading': heading,
      'info': info,
    };
  }
}
