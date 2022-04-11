import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/widgets/components/filter_modal.dart';
import 'package:packs/widgets/components/search_modal.dart';

class ExpandableSearchHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(color: PXColor.white),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: titlePosition(shrinkOffset),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Hi ${globals.currentUserData.firstName},\n',
                  style: TextStyle(
                    fontSize: 30,
                    color: PXColor.darkText
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ),
                TextSpan(
                  text: 'Explore ${globals.currentUserData.regionOfInterest}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: PXColor.darkText
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 12.0,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: PXColor.athensGrey,
              borderRadius: BorderRadius.circular(PXBorderRadius.radiusS),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.search, color: PXColor.pink),
                          SizedBox(width: 8),
                          Text(
                            'Try island hopping ..',
                            style: TextStyle(
                                color: CupertinoColors.placeholderText),
                          ),
                        ],
                      ),
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          expand: true,
                          topRadius:
                              const Radius.circular(PXBorderRadius.radiusL),
                          context: context,
                          builder: (BuildContext context) => Padding(
                            padding: const EdgeInsets.fromLTRB(
                                PXSpacing.spacingM,
                                PXSpacing.spacingXL,
                                PXSpacing.spacingM,
                                0),
                            child: SearchModal(),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(CupertinoIcons.slider_horizontal_3,
                        color: PXColor.darkText),
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        expand: true,
                        topRadius:
                            const Radius.circular(PXBorderRadius.radiusL),
                        context: context,
                        builder: (BuildContext context) => FilterModal(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 180.0;

  @override
  double get minExtent => 70.0;

  double titleOpacity(double shrinkOffset) {
    return max(0.0, 1 - ((shrinkOffset * 2) / maxExtent));
  }

  double titlePosition(double shrinkOffset) {
    // TODO: Remove magic number // 16.0 = title top spacing
    return 25.0 - (max(0.0, shrinkOffset) / 2.5);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
}
