import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PXRangeSlider extends StatefulWidget {
  const PXRangeSlider(
      {required this.title,
      this.icon,
      required this.min,
      required this.max,
      required this.values,
      required this.onChanged,
      this.enableTooltip = false});

  final String title;
  final IconData? icon;
  final double min;
  final double max;
  final SfRangeValues values;
  final bool? enableTooltip;
  final Function(SfRangeValues values) onChanged;

  @override
  State<PXRangeSlider> createState() => _PXRangeSliderState();
}

class _PXRangeSliderState extends State<PXRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: PXColor.athensGrey,
          borderRadius: BorderRadius.circular(PXBorderRadius.radiusM)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PXSpacing.spacingM,
          vertical: PXSpacing.spacingL,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: PXTextStyle.styleLRegular,
                ),
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    size: 24,
                    color: PXColor.darkText,
                  ),
              ],
            ),
            const SizedBox(height: PXSpacing.spacingM),
            SfRangeSlider(
              min: widget.min,
              max: widget.max,
              values: widget.values,
              // interval: widget.max / 2,
              showLabels: true,
              enableTooltip: widget.enableTooltip!,
              tooltipShape: SfPaddleTooltipShape(),
              stepSize: 1,
              activeColor: PXColor.neonGreen,
              inactiveColor: PXColor.lightGrey,
              onChanged: (SfRangeValues values) => widget.onChanged(values),
            ),
          ],
        ),
      ),
    );
  }
}
