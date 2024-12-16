import 'package:flutter/material.dart';
import 'package:tdot_gkr/models/information/paragraph.model.dart';

class TextParagraphWidget extends StatefulWidget {
  final InformationParagraph paragraph;

  const TextParagraphWidget({super.key, required this.paragraph});

  @override
  State<TextParagraphWidget> createState() => _TextParagraphWidgetState();
}

class _TextParagraphWidgetState extends State<TextParagraphWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.paragraph.heading?.isNotEmpty ?? false)
                Text(
                  widget.paragraph.heading!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 8.0),
              Text(
                widget.paragraph.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          if (widget.paragraph.info?.isNotEmpty ?? false)
            Positioned(
              top: 0,
              right: 0,
              child: Tooltip(
                message: widget.paragraph.info!,
                showDuration: const Duration(
                  seconds: 5,
                ),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                triggerMode: TooltipTriggerMode.tap,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Icon(
                  Icons.info_outline,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
