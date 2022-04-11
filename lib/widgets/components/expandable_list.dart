import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class ExpandableList extends StatefulWidget {
  final List<String> items;

  ExpandableList({required this.items});

  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  var expanded = false;

  @override
  Widget build(BuildContext context) {
    var itemsCount = expanded ? widget.items.length : 3;

    final items = widget.items.sublist(0, itemsCount);

    return Container(
      child: Column(
        children: [
          for (final item in items)
            Column(children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.check_mark_circled,
                    color: PXColor.darkText,
                    size: 20,
                  ),
                  SizedBox(width: PXSpacing.spacingS),
                  Text(item),
                ],
              ),
              SizedBox(height: PXSpacing.spacingS)
            ]),
          if (widget.items.length > 3)
            Column(
              children: [
                SizedBox(height: PXSpacing.spacingS),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        expanded ? 'Show less' : 'Show all',
                        style: PXTextStyle.styleMRegular,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          expanded
                              ? CupertinoIcons.chevron_up
                              : CupertinoIcons.chevron_right,
                          size: 16,
                          color: PXColor.darkText,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() => {
                          expanded = !expanded,
                        });
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
