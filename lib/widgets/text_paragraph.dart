import 'package:flutter/cupertino.dart';
import 'package:tdot_gkr/models/information/paragraph.model.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
              if (widget.paragraph.link?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8.0),
                CupertinoButton(
                  onPressed: () => {
                    launchUrl(
                      Uri.parse(widget.paragraph.link!),
                      mode: LaunchMode.externalApplication,
                    ),
                  },
                  child: Text(
                    widget.paragraph.text,
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 8.0),
                Text(
                  widget.paragraph.text,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              ],
            ],
          ),
          if (widget.paragraph.info?.isNotEmpty ?? false)
            Positioned(
              top: 0,
              right: 0,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoPopupSurface(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.paragraph.info!,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle,
                            ),
                            const SizedBox(height: 16.0),
                            CupertinoButton(
                              child: const Text('Close'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  CupertinoIcons.info,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
