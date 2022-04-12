import 'package:flutter/cupertino.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/deal_card.dart';

class DealsSliverList extends StatefulWidget {
  ScrollController scrollController;
  List<String>? queryDocIDs;

  DealsSliverList({this.queryDocIDs, required this.scrollController});

  @override
  _DealsSliverListState createState() => _DealsSliverListState();
}

class _DealsSliverListState extends State<DealsSliverList> {
  late DealsModel model;

  @override
  void initState() {
    model = DealsModel(queryDocIDs: widget.queryDocIDs);

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent ==
          widget.scrollController.offset) {
        model.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: model.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SliverList(
            delegate: SliverChildListDelegate([
              const Center(
                child: Text("Loading.."),
              ),
            ]),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index < snapshot.data.length) {
                  return DealCard(model: snapshot.data[index]);
                }

                // TODO: - Einkommentieren, wenn `hasMore` korrekt berechnet wird
                // else if (deals.hasMore == true) {
                //   return Center(
                //     child: Text("Loading.."),
                //   );
                // }
              },
              childCount:
                  snapshot.data.length < 10 ? snapshot.data.length + 1 : 10,
            ),
          );
        }
      },
    );
  }
}
