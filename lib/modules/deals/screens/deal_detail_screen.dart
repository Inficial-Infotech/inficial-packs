import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';
// Widgets:
import 'package:packs/modules/deals/screens/deal_detail_about_screen.dart';
import 'package:packs/modules/deals/screens/deal_detail_contact_screen.dart';
import 'package:packs/modules/deals/screens/deal_detail_reviews_screen.dart';
import 'package:packs/widgets/components/expandable_image_slider_header.dart';
import 'package:packs/widgets/components/segmented_control.dart';

const segmentedControlSegments = ['Details', 'Reviews', 'Info'];

class DealDetailScreen extends StatefulWidget {
  static const String id = "DealDetailScreen";

  final DealModel model;
  DealDetailScreen({required this.model});

  @override
  _DealDetailScreen createState() => _DealDetailScreen();
}

class _DealDetailScreen extends State<DealDetailScreen> {
  final scrollController = ScrollController();

  var segmentedControlValue = 0;

  void callback(int segmentedControlValue) {
    setState(() {
      this.segmentedControlValue = segmentedControlValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: ExpandableImageSliderHeader(model: widget.model),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(PXSpacing.spacingXL),
                    child: SegmentedControl(
                      items: segmentedControlSegments,
                      segmentedControlValue: segmentedControlValue,
                      callback: this.callback,
                    ),
                  ),
                  Container(
                    child: [
                      DealDetailScreenAbout(model: widget.model),
                      DealDetailScreenReviews(model: widget.model),
                      DealDetailScreenContact(model: widget.model)
                    ][segmentedControlValue],
                  ),
                ]),
              ),
              SliverFillRemaining(),
            ],
          ),
        ],
      ),
    );
  }
}
