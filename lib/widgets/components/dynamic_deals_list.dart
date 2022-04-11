import 'package:flutter/cupertino.dart';
import 'package:algolia/algolia.dart';
import 'package:packs/utils/services/algolia_manager.dart';
import 'package:packs/models/DealModel.dart';
// Widgets:
import 'package:packs/widgets/components/deal_card.dart';

class DynamicDealsList extends StatelessWidget {
  ScrollController scrollController;
  AlgoliaQuery algoliaQuery;

  DynamicDealsList(
      {required this.scrollController, required this.algoliaQuery});

  final AlgoliaManager _algolia = AlgoliaManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _algolia.getDealsForQuery(query: algoliaQuery),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          // Loading state?
          default:
            if (snapshot.hasError) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final data = snapshot.data;
              if (data == null) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CupertinoActivityIndicator(),
                );
              } else {
                final model = data as List<DealModel>;
                return ListView.builder(
                  controller: scrollController,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return DealCard(model: model[index]);
                  },
                );
              }
            }
        }
      },
    );
  }
}
