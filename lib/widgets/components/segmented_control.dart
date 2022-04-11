import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class SegmentedControl extends StatefulWidget {
  final List<String> items;
  final int segmentedControlValue;
  final Function(int) callback;

  SegmentedControl({
    required this.items,
    required this.segmentedControlValue,
    required this.callback,
  });

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: widget.items
            .asMap()
            .entries
            .map(
              (item) => SegmentedControlThumb(
                title: item.value,
                isActive: widget.segmentedControlValue == item.key,
                callback: () => widget.callback(item.key),
              ),
            )
            .toList(),
      ),
    );
  }
}

class SegmentedControlThumb extends StatefulWidget {
  final String title;
  final bool isActive;
  final Function() callback;

  SegmentedControlThumb({
    required this.title,
    required this.isActive,
    required this.callback,
  });

  @override
  State<SegmentedControlThumb> createState() => _SegmentedControlThumbState();
}

class _SegmentedControlThumbState extends State<SegmentedControlThumb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: PXSpacing.spacingM),
      child: GestureDetector(
        onTap: () => widget.callback(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Fix animation
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: widget.isActive
                  ? PXTextStyle.styleLBold
                  : PXTextStyle.styleLRegular,
              child: Text(
                this.widget.title,
                style: TextStyle(color: PXColor.black),
              ),
            ),
            SizedBox(height: PXSpacing.spacingXXS),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 2,
              width: widget.isActive ? 40 : 0,
              decoration: BoxDecoration(
                color: PXColor.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
