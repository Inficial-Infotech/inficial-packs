import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/widgets/components/bar_button.dart';

class PXSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  PXSliverPersistentHeaderDelegate({
    required this.openHeight,
    required this.closedHeight,
    this.title,
    this.subtitle,
    this.child,
    this.hasBackButton,
    this.barButtons,
    this.images,
  });

  double openHeight;
  double closedHeight;
  String? title;
  String? subtitle;
  Widget? child;
  bool? hasBackButton = false;
  List<PXBarButton>? barButtons;
  List<Image>? images;

  bool debug = false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      fit: StackFit.expand,
      children: <Widget>[
        // MARK: - HeroImages
        if (images != null)
          Positioned(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(), // this for snapping
              itemCount: images!.length,
              itemBuilder: (_, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: images![index],
                );
              },
            ),
          ),

        // MARK: - Children
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: debug ? PXColor.lightGrey : PXColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(PXBorderRadius.radiusL),
                topRight: Radius.circular(PXBorderRadius.radiusL),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                PXSpacing.spacingM,
                PXSpacing.spacingL,
                PXSpacing.spacingM,
                PXSpacing.spacingXS,
              ),
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
        // if (debug == true)
        //   Positioned(
        //     left: 0,
        //     right: 0,
        //     top: PXSpacing.spacingL,
        //     child: Container(
        //       height: PXSpacing.spacingL,
        //       color: PXColor.red,
        //     ),
        //   ),

        // MARK: - Nav Bar
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            color: images != null ? PXColor.transparent : PXColor.white,
            child: SafeArea(
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
        ),
      ],
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
    return max(0.0, 1 - ((shrinkOffset * 2) / maxExtent));
  }

  double titlePosition(double shrinkOffset) {
    return 25.0 - (max(0.0, shrinkOffset) / 2.5);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
