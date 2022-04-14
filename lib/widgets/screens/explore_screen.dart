import 'package:flutter/cupertino.dart';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:packs/utils/services/algolia_manager.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/deal_card.dart';
// Widgets:
import 'package:packs/widgets/components/explore_map.dart';
import 'package:packs/widgets/components/mate_detail_card.dart';
import 'package:packs/widgets/components/segmented_control.dart';

class ExploreScreen extends StatefulWidget {
  final AlgoliaQuery algoliaQuery;

  ExploreScreen({required this.algoliaQuery});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final AlgoliaManager _algolia = AlgoliaManager();
  TextEditingController searchController = TextEditingController();
  List<DealModel> _dealModels = [];
  final scrollController = ScrollController();
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();

  var segmentedControlValue = 0;
  var segmentedControlSegments = ['All', 'Adventures', 'Vouchers', 'Meetups','Mates'];

  void callback(int segmentedControlValue) {
    setState(() {
      this.segmentedControlValue = segmentedControlValue;
    });
    if (segmentedControlValue == 4 && draggableScrollableController.size <= 0.8) {
      draggableScrollableController.animateTo(1, duration: const Duration(milliseconds: 200),curve: Curves.easeIn);
    }
  }
  void initState() {
    super.initState();

    _fetchDealModels();
  }

  Future<void> _fetchDealModels() async {
    final deals = await _algolia.getDealsForQuery(query: widget.algoliaQuery);

    setState(() {
      _dealModels = deals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            ExploreMap(dealModels: _dealModels),
            Container(
              color: PXColor.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.back,
                            color: PXColor.darkText),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: CupertinoTextField(
                              decoration: BoxDecoration(
                                color: PXColor.boxColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              controller: searchController,
                              padding: EdgeInsets.all(10),
                              prefix:  Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(CupertinoIcons.search, color: PXColor.pink),
                              ),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: Icon(CupertinoIcons.slider_horizontal_3,
                                    color: PXColor.darkText),
                              ),
                            ),
                          )
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PXSpacing.spacingM),
                      child: SegmentedControl(
                        items: segmentedControlSegments,
                        segmentedControlValue: segmentedControlValue,
                        callback: this.callback,
                        images: ['',PXImages.adventure,PXImages.voucher,PXImages.meetups,PXImages.meetups],
                        activeTextColor: PXColor.pink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.3,
                maxChildSize: 0.88,
                snap: true,
                controller: draggableScrollableController,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  double? viewPort = 0.0;
                  viewPort = draggableScrollableController.size * 1000;
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: viewPort > 350 ? 0 : 50),
                        decoration: BoxDecoration(
                          color: PXColor.white,
                          borderRadius:
                              BorderRadius.circular(viewPort > 350 ? 0 :  PXBorderRadius.radiusL),
                          boxShadow: viewPort > 350 ? [] : [
                            BoxShadow(
                              color: PXColor.lightGrey,
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: segmentedControlValue == 4 ? Padding(
                          padding: const EdgeInsets.all(PXSpacing.spacingM),
                          child: _dealModels.isNotEmpty
                              ? ListView.builder(
                            controller: scrollController,
                            itemCount: _dealModels.length,
                            itemBuilder: (context, index) {
                              return MateDetailCard(image: _dealModels[index].titleImage,age: '29',gender: 'Male',name: 'John smith',);
                            },
                          )
                              : Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: CupertinoActivityIndicator(),
                          ),
                        ) : Padding(
                          padding: const EdgeInsets.all(PXSpacing.spacingM),
                          child: _dealModels.isNotEmpty
                              ? ListView.builder(
                                  controller: scrollController,
                                  itemCount: _dealModels.length,
                                  itemBuilder: (context, index) {
                                    return DealCard(model:  _dealModels[index],showMeetups: segmentedControlValue == 3,);
                                  },
                                )
                              : Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: CupertinoActivityIndicator(),
                                ),
                        ),
                      ),
                      AnimatedContainer(
                        margin: EdgeInsets.only(top: viewPort > 350 ? 0 : 30,),
                        height: viewPort > 350 ? 0 : 50,
                        alignment: Alignment.topCenter, duration: const Duration(milliseconds: 200),
                        child: const Text('Island hopping, 8',style: PXTextStyle.styleLBold),
                      ),
                       IgnorePointer(
                        ignoring: true,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height:   viewPort > 350 ? 0 : 20,
                          child: Center(
                            child: SizedBox(
                              height: 5,
                              width: 60,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: PXColor.mysticGreen,
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
