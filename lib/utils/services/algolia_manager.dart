import 'package:algolia/algolia.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:packs/models/DealModel.dart';

// TODO: Check why `timestamp` is causing errors in deal model

class AlgoliaManager {
  Future<List<DealModel>> getDealsForQuery({
    required AlgoliaQuery query,
  }) async {
    List<DealModel>? deals = [];

    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;

    for (final snap in results) {
      deals.add(DealModel.fromJson(snap.data));
    }

    // TODO: Refactor
    for (var deal in deals) {
      final ref = FirebaseStorage.instance.ref().child(deal.titleImage!);
      final url = await ref.getDownloadURL();
      deal.titleImage = url;
    }

    return deals;
  }
}
