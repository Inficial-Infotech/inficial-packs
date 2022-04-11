import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:packs/utils/services/algolia_application.dart';
import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/utils/services/algolia_manager.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/models/SearchResultRowModel.dart';
// Widgets:
import 'package:packs/widgets/screens/explore_screen.dart';

class SearchModal extends StatefulWidget {
  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  final AlgoliaManager _algolia = AlgoliaManager();
  String _searchString = "";

  AlgoliaQuery _algoliaQuery =
      AlgoliaApplication.algolia.instance.index(AlgoliaApplication.dealsIndex);

  // AlgoliaApplication.algolia.instance.index(AlgoliaApplication.dealsIndex).query(_searchString))

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Eigene komponente
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 24,
            ),
            Expanded(
              child: IgnorePointer(
                ignoring: true,
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
            GestureDetector(
              child: Icon(CupertinoIcons.xmark, color: PXColor.darkText),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        SizedBox(
          height: PXSpacing.spacingXL,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: PXColor.athensGrey,
            borderRadius: BorderRadius.circular(PXBorderRadius.radiusS),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PXSpacing.spacingM),
            child: Row(
              children: [
                Icon(CupertinoIcons.search, color: PXColor.pink),
                SizedBox(width: 8),
                Expanded(
                  child: CupertinoTextField(
                    autofocus: true,
                    placeholder: "Try island hopping ..",
                    decoration: BoxDecoration(
                      color: PXColor.transparent,
                    ),
                    onChanged: (String value) {
                      setState(() => {
                            _searchString = value,
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: PXSpacing.spacingXL,
        ),
        StreamBuilder<List<DealModel>>(
          stream: Stream.fromFuture(_algolia.getDealsForQuery(
              query: _algoliaQuery.query(_searchString))),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator();
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CupertinoActivityIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data;
                    if (data == null) return Text("Error loading data");

                    List<SearchResultRowModel> searchResultRowModels = [];
                    for (final deal in data) {
                      final title = deal.name;
                      if (title == null) continue;

                      final existingElement =
                          searchResultRowModels.where((e) => e.title == title);
                      if (existingElement.isEmpty) {
                        searchResultRowModels
                            .add(SearchResultRowModel(title: title, count: 1));
                      } else {
                        existingElement.first.count += 1;
                      }
                    }
                    searchResultRowModels
                        .sort((lhs, rhs) => rhs.count.compareTo(lhs.count));

                    return _searchString.length > 0
                        ? CustomScrollView(
                            shrinkWrap: true,
                            slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final searchResultRowModel =
                                        searchResultRowModels[index];

                                    return GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: PXSpacing.spacingXL),
                                        child: Row(
                                          children: [
                                            Text(searchResultRowModel.title),
                                            Spacer(),
                                            Text(
                                                "${searchResultRowModel.count}"),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => ExploreScreen(
                                                algoliaQuery: _algoliaQuery
                                                    .query(searchResultRowModel
                                                        .title)),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  childCount: searchResultRowModels.length < 6
                                      ? searchResultRowModels.length
                                      : 6,
                                ),
                              ),
                            ],
                          )
                        : Container();
                  }
              }
            }
          },
        ),
      ],
    );
  }
}
