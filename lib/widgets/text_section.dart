import 'package:flutter/material.dart';
import 'package:tdot_gkr/models/information/section.model.dart';
import 'package:tdot_gkr/widgets/text_paragraph.dart';

class TextSectionWidget extends StatefulWidget {
  final InformationSection section;

  const TextSectionWidget({super.key, required this.section});

  @override
  State<TextSectionWidget> createState() => _TextSectionWidgetState();
}

class _TextSectionWidgetState extends State<TextSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.section.heading,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ...widget.section.paragraphs.map<Widget>((paragraph) {
            return TextParagraphWidget(paragraph: paragraph);
          }),
        ],
      ),
    );
  }
}
