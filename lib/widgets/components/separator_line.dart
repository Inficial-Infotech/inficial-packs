import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(
          horizontal: PXSpacing.spacingXL, vertical: PXSpacing.spacingM),
      color: PXColor.athensGrey,
    );
  }
}
