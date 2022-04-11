import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/widgets/components/bar_button.dart';

class PXSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  PXSliverPersistentHeaderDelegate({
    required this.closedHeight,
    required this.openHeight,
    this.title,
    this.subtitle,
    this.child,
    this.hasBackButton,
    this.barButtons,
  });

  double closedHeight;
  double openHeight;
  String? title;
  String? subtitle;
  Widget? child;
  bool? hasBackButton = false;
  List<PXBarButton>? barButtons;

  bool debug = false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        fit: StackFit.expand,
        children: <Widget>[
          // MARK: - Children
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              color: debug ? PXColor.lightGrey : PXColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PXSpacing.spacingM),
                child: Opacity(
                  opacity: childOpacity(shrinkOffset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (title != null)
                        Text(title!, style: PXTextStyle.pageTitle),
                      if (subtitle != null)
                        Text(subtitle!, style: PXTextStyle.styleMRegular),
                      if (child != null)
                        Container(
                          color: debug ? PXColor.orange : PXColor.white,
                          child: Column(
                            children: [
                              const SizedBox(height: PXSpacing.spacingM),
                              child!,
                              const SizedBox(height: PXSpacing.spacingXS),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // MARK: - Debug Spacer
          if (debug == true)
            Positioned(
              left: 0,
              right: 0,
              top: PXSpacing.spacingL,
              child: Container(
                height: PXSpacing.spacingL,
                color: PXColor.red,
              ),
            ),

          // MARK: - Nav Bar
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: debug ? PXColor.grey : PXColor.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PXSpacing.spacingS,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (hasBackButton != null && hasBackButton! == true)
                      PXBarButton(
                        icon: CupertinoIcons.chevron_back,
                        onTap: () => {
                          Navigator.pop(context),
                        },
                      ),
                    if (title != null)
                      Expanded(
                        child: Opacity(
                          opacity: titleOpacity(shrinkOffset),
                          child: Text(
                            title!,
                            style: PXTextStyle.styleSRegular,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    if (barButtons != null)
                      Row(
                        children: [
                          for (final Widget item in barButtons!)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: PXSpacing.spacingXS,
                              ),
                              child: item,
                            )
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => openHeight;

  @override
  double get minExtent => closedHeight;

  double titleOpacity(double shrinkOffset) {
    return max(0.0, shrinkOffset / maxExtent);
  }

  double childOpacity(double shrinkOffset) {
    return max(0.0, 1 - ((shrinkOffset * 3) / maxExtent));
  }

  double titlePosition(double shrinkOffset) {
    return 25.0 - (max(0.0, shrinkOffset) / 2.5);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
