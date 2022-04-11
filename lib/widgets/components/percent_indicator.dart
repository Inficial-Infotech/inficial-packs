import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class PercentIndicator extends StatelessWidget {
  final String title;
  final double value;

  PercentIndicator({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: PXTextStyle.styleMRegular),
            Spacer(),
            Text(value.toStringAsFixed(1), style: PXTextStyle.styleMRegular),
          ],
        ),
        SizedBox(height: PXSpacing.spacingS),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: PXColor.lightGrey,
                borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
              ),
            ),
            FractionallySizedBox(
              widthFactor: max(value, 0.1),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: PXColor.primary,
                  borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: PXSpacing.spacingL)
      ],
    );
  }
}
