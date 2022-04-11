import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/models/DealModel.dart';
// Widgets:

class ExpandableImageSliderHeader extends SliverPersistentHeaderDelegate {
  final DealModel model;

  ExpandableImageSliderHeader({required this.model});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          color: PXColor.white,
        ),
        Opacity(
          opacity: titleOpacity(shrinkOffset),
          child: GestureDetector(
            child: Container(
              child: Image.network(
                model.titleImage!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              // TODO: go to image gallery
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: PXColor.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(PXBorderRadius.radiusL),
                  bottom: Radius.zero),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PXSpacing.spacingM, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: PXCardDecoration(
                      icon: CupertinoIcons.chevron_left,
                      opacity: titleOpacity(shrinkOffset)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: PXCardDecoration(
                      icon: CupertinoIcons.share,
                      opacity: titleOpacity(shrinkOffset)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  child: PXCardDecoration(
                      icon: CupertinoIcons.heart,
                      opacity: titleOpacity(shrinkOffset)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 260.0;

  @override
  double get minExtent => 90.0;

  double titleOpacity(double shrinkOffset) {
    return max(0, (1 - ((shrinkOffset * 2) / maxExtent)));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
}

class PXCardDecoration extends StatelessWidget {
  final double opacity;
  final IconData icon;

  PXCardDecoration({required this.opacity, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PXColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PXColor.darkText.withOpacity(max(0, opacity - 0.6)),
            blurRadius: 7,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          icon,
          color: PXColor.black,
          size: 17,
        ),
      ),
    );
  }
}
