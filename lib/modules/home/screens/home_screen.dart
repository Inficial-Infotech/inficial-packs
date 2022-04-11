import 'dart:math';

import 'package:algolia/algolia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:packs/utils/services/algolia_application.dart';
import 'package:packs/utils/services/algolia_manager.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/deal_card.dart';
// Widgets:
import 'package:packs/widgets/screens/explore_screen.dart';
import 'package:packs/widgets/components/tab_bar.dart';
import 'package:packs/widgets/components/expandable_search_header.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  final AlgoliaManager _algolia = AlgoliaManager();
  final _algoliaQuery = AlgoliaApplication.algolia.instance
      .index(AlgoliaApplication.dealsIndex)
      .facetFilter('active:true')
      .setMaxValuesPerFacet(2);

  List<DealModel> _dealModels = [];

  void initState() {
    super.initState();

    _fetchDealModels();
  }

  Future<void> _fetchDealModels() async {
    final deals = await _algolia.getDealsForQuery(query: _algoliaQuery);

    setState(() {
      _dealModels = deals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: CupertinoPageScaffold(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: ExpandableSearchHeader(),
                    ),
                    // SliverAnimatedList(
                    //   initialItemCount: _dealModels.length,
                    //   itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                    //     return Text('xx');
                    //   },
                    // ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _dealModels.isNotEmpty
                              ? DealCard(model: _dealModels[index])
                              : CupertinoActivityIndicator();
                        },
                        childCount: max(_dealModels.length,
                            1), // The 1 represents CupertinoActivityIndicator()
                      ),
                    ),
                    // DealsSliverList(scrollController: scrollController),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: PXSpacing.spacingS),
                          CupertinoButton.filled(
                            child: Text("Explore on Map"),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ExploreScreen(
                                      algoliaQuery: _algoliaQuery),
                                ),
                              );
                            },
                          ),
                          Container(height: 150),
                        ],
                      ),
                    ),
                  ],
                ),
                PXTabBar(activeRouteId: HomeScreen.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
