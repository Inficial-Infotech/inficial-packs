import 'package:flutter/cupertino.dart';
import 'package:algolia/algolia.dart';
import 'package:packs/utils/services/algolia_manager.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/deal_card.dart';
// Widgets:
import 'package:packs/widgets/components/explore_map.dart';

class ExploreScreen extends StatefulWidget {
  final AlgoliaQuery algoliaQuery;

  ExploreScreen({required this.algoliaQuery});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final AlgoliaManager _algolia = AlgoliaManager();
  List<DealModel> _dealModels = [];

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
      child: Stack(
        children: [
          ExploreMap(dealModels: _dealModels),
          SafeArea(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 170,
                margin: EdgeInsets.only(bottom: 70),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
// DealCard(cardType: DealCardType.normal),
// DealCard(cardType: DealCardType.normal),
                  ],
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.1,
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: PXColor.white,
                        borderRadius:
                            BorderRadius.circular(PXBorderRadius.radiusL),
                        boxShadow: [
                          BoxShadow(
                            color: PXColor.lightGrey,
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(PXSpacing.spacingM),
                        child: _dealModels.isNotEmpty
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount: _dealModels.length,
                                itemBuilder: (context, index) {
                                  return DealCard(model: _dealModels[index]);
                                },
                              )
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: const CupertinoActivityIndicator(),
                              ),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Container(
                        height: 50,
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
    );
  }
}
