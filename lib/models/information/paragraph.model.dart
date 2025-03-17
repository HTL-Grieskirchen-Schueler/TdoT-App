class InformationParagraph {
  String text;
  String? heading;
  String? info;
  String? link;

  InformationParagraph({
    required this.text,
    this.heading,
    this.info,
    this.link,
  });

  factory InformationParagraph.fromJson(Map<String, dynamic> json) {
    return InformationParagraph(
      text: json['text'],
      heading: json['heading'],
      info: json['info'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'heading': heading,
      'info': info,
      'link': link,
    };
  }
}
