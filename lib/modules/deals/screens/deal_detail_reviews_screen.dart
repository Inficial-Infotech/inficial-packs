import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/percent_indicator.dart';

class DealDetailScreenReviews extends StatelessWidget {
  final DealModel model;

  DealDetailScreenReviews({required this.model});

  @override
  Widget build(BuildContext context) {
    final reviews = model.reviews;

    if (reviews != null) {
      var averageRating = 0.0;
      for (final review in model.reviews!) {
        averageRating += review.value;
      }
      averageRating = averageRating / model.reviews!.length;

      return Container(
        color: PXColor.athensGrey,
        child: Padding(
          padding: const EdgeInsets.all(PXSpacing.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Rated: ", style: PXTextStyle.styleMBold),
                  Text(averageRating.toStringAsFixed(1),
                      style: PXTextStyle.styleMBold),
                  Spacer(),
                ],
              ),
              SizedBox(height: PXSpacing.spacingXL),
              if (model.rating != null)
                for (final item in model.rating!)
                  PercentIndicator(
                    title: item.title,
                    value: item.value,
                  ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
