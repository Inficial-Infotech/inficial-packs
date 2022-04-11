import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';

// Widgets:
import 'package:packs/widgets/components/accordion.dart';
import 'package:packs/widgets/components/expandable_list.dart';
import 'package:packs/widgets/components/horizontal_card_slider.dart';
import 'package:packs/widgets/components/icon_text_card.dart';
import 'package:packs/widgets/components/separator_line.dart';
import 'package:packs/widgets/components/table_row_title.dart';

class DealDetailScreenAbout extends StatelessWidget {
  final DealModel model;

  DealDetailScreenAbout({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: PXColor.athensGrey,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.clock, color: PXColor.darkText),
                    SizedBox(height: PXSpacing.spacingXS),
                    Text('Duration', style: PXTextStyle.styleMBold),
                    SizedBox(height: PXSpacing.spacingXXS),
                    Text('7.5 hours', style: PXTextStyle.styleMRegular),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.person_2, color: PXColor.darkText),
                    SizedBox(height: PXSpacing.spacingXS),
                    Text('Group', style: PXTextStyle.styleMBold),
                    SizedBox(height: PXSpacing.spacingXXS),
                    Text('Max. 6', style: PXTextStyle.styleMRegular),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.star, color: PXColor.darkText),
                    SizedBox(height: PXSpacing.spacingXS),
                    Text('Rating', style: PXTextStyle.styleMBold),
                    SizedBox(height: PXSpacing.spacingXXS),
                    Text('4,7', style: PXTextStyle.styleMRegular),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: PXSpacing.spacingM),

        // MARK: - The experience
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PXTableRowTitle(title: 'The experience'),
                Text(model.description ?? 'xx',
                    style: PXTextStyle.styleMRegular),
              ],
            ),
          ),
        ),
        DividerLine(),

        // MARK: - What’s included
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PXSpacing.spacingXL),
                  child: PXTableRowTitle(title: 'What’s included'),
                ),
                HorizontalCardSlider(
                  items: model.whatsIncluded!,
                  iconColor: PXColor.darkText,
                )
              ],
            ),
          ),
        ),

        // MARK: - What to bring
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PXTableRowTitle(title: 'What to bring'),
                ExpandableList(
                  items: model.whatToBring!,
                ),
              ],
            ),
          ),
        ),

        // MARK: - Itinerary
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PXTableRowTitle(title: 'Itinerary'),
                for (final item in model.itinerary!)
                  IconTextCard(
                    type: IconTextCardType.expandable,
                    title: item.title!,
                    text: item.text!,
                    backgroundColor: PXColor.athensGrey,
                  ),
              ],
            ),
          ),
        ),
        DividerLine(),

        // MARK: - COVID-19 Measures
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PXSpacing.spacingXL),
                  child: PXTableRowTitle(title: 'COVID-19 Measures'),
                ),
                HorizontalCardSlider(
                  items: model.covidMeasures!,
                  iconColor: PXColor.red,
                )
              ],
            ),
          ),
        ),

        // MARK: - Cancellation policy
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PXTableRowTitle(title: 'Cancellation policy'),
                Text(model.cancellationPolicy!.text!,
                    style: PXTextStyle.styleMRegular),
              ],
            ),
          ),
        ),
        DividerLine(),

        // MARK: - Specials
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(PXSpacing.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PXTableRowTitle(title: 'Available specials'),
                for (final item in model.specials!)
                  IconTextCard(
                    type: IconTextCardType.expandable,
                    icon: CupertinoIcons.moon_stars_fill,
                    title: item.title!,
                    subtitle: '+ \$90 / person',
                    text: item.text!,
                    backgroundColor: PXColor.athensGrey,
                  ),
              ],
            ),
          ),
        ),
        DividerLine(),

        // TODO: Add related deals
        // MARK: - Related deals
        // Container(),
      ],
    );
  }
}
