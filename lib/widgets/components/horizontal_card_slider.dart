import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/IconTitleTextModel.dart';

class HorizontalCardSlider extends StatelessWidget {
  final List<IconTitleTextModel> items;
  var iconColor = PXColor.red;

  HorizontalCardSlider({required this.items, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: PXSpacing.spacingXL,
          ),
          for (final model in items)
            Padding(
              padding: EdgeInsets.only(right: PXSpacing.spacingM),
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: PXColor.athensGrey),
                  borderRadius:
                      BorderRadius.all(Radius.circular(PXBorderRadius.radiusS)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      PXSpacing.spacingM,
                      PXSpacing.spacingXL,
                      PXSpacing.spacingS,
                      PXSpacing.spacingS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.icon != null)
                        Icon(PXIcons[model.icon],
                            color: this.iconColor, size: 30),
                      SizedBox(height: PXSpacing.spacingS),
                      Text(model.title!, style: PXTextStyle.styleMBold),
                      SizedBox(height: PXSpacing.spacingXS),
                      Text(model.text!, style: PXTextStyle.styleMRegular),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
