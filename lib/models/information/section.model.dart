import 'package:tdot_gkr/models/information/paragraph.model.dart';

class InformationSection {
  String? heading;
  List<InformationParagraph> paragraphs;

  InformationSection({required this.heading, required this.paragraphs});

  factory InformationSection.fromJson(Map<String, dynamic> json) {
    return InformationSection(
      heading: json['heading'],
      paragraphs: ((json['paragraphs'] as List?) ?? [])
          .map((item) => InformationParagraph.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'paragraphs': paragraphs.map((item) => item.toJson()).toList(),
    };
  }
}
