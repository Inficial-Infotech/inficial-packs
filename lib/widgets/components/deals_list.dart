import 'package:flutter/cupertino.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/widgets/components/deal_card.dart';

/// Deprecated: Use DynamicDealsList instead
class DealsList extends StatefulWidget {
  ScrollController scrollController;
  List<String>? queryDocIDs;

  DealsList({this.queryDocIDs, required this.scrollController});

  @override
  _DealsListState createState() => _DealsListState();
}

class _DealsListState extends State<DealsList> {
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
      builder: (BuildContext context, AsyncSnapshot<List<DealModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('Loading'));
        } else {
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: snapshot.data!.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < snapshot.data!.length) {
                return DealCard(model: snapshot.data![index]);
              } else if (model.hasMore == true) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(child: Text('Loading')),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(child: Text('nothing more to load!')),
                );
              }
            },
          );
        }
      },
    );
  }
}
