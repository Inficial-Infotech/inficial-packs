import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class Accordion extends StatelessWidget {
  final List<AccordionItem> items;

  Accordion({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (final child in items)
            Container(
              margin: EdgeInsets.only(
                  top: child.title != items.first.title
                      ? PXSpacing.spacingM
                      : 0),
              child: child,
            ),
        ],
      ),
    );
  }
}

class AccordionItem extends StatefulWidget {
  final String title;
  final String text;

  AccordionItem({required this.title, required this.text});

  @override
  _AccordionItemState createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem> {
  var expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: PXColor.athensGrey,
        borderRadius: BorderRadius.all(Radius.circular(PXBorderRadius.radiusS)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PXSpacing.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: PXTextStyle.styleLRegular,
                  ),
                  Spacer(),
                  Icon(
                      expanded
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      color: PXColor.darkText)
                ],
              ),
              onTap: () {
                setState(() => {
                      expanded = !expanded,
                    });
              },
            ),
            if (expanded)
              Container(
                margin: EdgeInsets.only(top: PXSpacing.spacingS),
                child: Text(widget.text, style: PXTextStyle.styleMRegular),
              ),
          ],
        ),
      ),
    );
  }
}
