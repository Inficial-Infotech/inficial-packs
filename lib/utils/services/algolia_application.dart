import 'package:algolia/algolia.dart';

class AlgoliaApplication {
  static final Algolia algolia = Algolia.init(
    applicationId: "FB95K3LF25", //ApplicationID
    apiKey:
        "ba04ffe93393b541175f8e0bda3b2b51", //search-only api key in flutter code
  );

  // Indices
  static final dealsIndex = "packs_deals";
}

// extension Indices on AlgoliaApplication {
// }
