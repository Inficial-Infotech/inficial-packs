import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class SegmentedControl extends StatefulWidget {
  final List<String> items;
  final int segmentedControlValue;
  final Function(int) callback;

  const SegmentedControl({
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
              (MapEntry<int, String> item) => SegmentedControlThumb(
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
  const SegmentedControlThumb({
    required this.title,
    required this.isActive,
    required this.callback,
  });

  final String title;
  final bool isActive;
  final Function() callback;

  @override
  State<SegmentedControlThumb> createState() => _SegmentedControlThumbState();
}

class _SegmentedControlThumbState extends State<SegmentedControlThumb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: PXSpacing.spacingM),
      child: GestureDetector(
        onTap: () => widget.callback(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Fix animation using AnimatedCrossFade
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: widget.isActive
                  ? PXTextStyle.styleLBold
                  : PXTextStyle.styleLRegular,
              child: Text(
                widget.title,
                style: const TextStyle(color: PXColor.black),
              ),
            ),
            const SizedBox(height: PXSpacing.spacingXXS),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
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
