import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:packs/models/AddressModel.dart';
import 'package:packs/models/GeoPointModel.dart';
import 'package:packs/models/IconTitleTextModel.dart';
import 'package:packs/models/PriceModel.dart';
import 'package:packs/models/RatingModel.dart';
import 'package:packs/models/ReviewModel.dart';
import 'package:packs/utils/services/database_manager.dart';

part 'DealModel.g.dart';

@JsonSerializable(explicitToJson: true)
class DealModel {
  String? uid;
  bool? active;
  // @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  // DateTime? createdAt;
  String? category;
  // CollectionReference? company;
  String? name;
  String? description;
  bool? ecoCertified;
  int? groupSize;
  int? availableSpaces;
  // List<StartEndDateModel>? availableDates;
  AddressModel? address;
  GeoPointModel? geoloc;
  PriceModel? price;
  bool? specialOffer;
  List<String>? whatToBring;
  String? titleImage;
  List<String>? galleryImages;
  List<IconTitleTextModel>? itinerary;
  List<IconTitleTextModel>? whatsIncluded;
  List<IconTitleTextModel>? specials;
  List<IconTitleTextModel>? covidMeasures;
  IconTitleTextModel? cancellationPolicy;
  List<RatingModel>? rating;
  List<ReviewModel>? reviews;

  DealModel({
    this.uid,
    this.active,
    // this.createdAt,
    this.category,
    // this.company,
    this.name,
    this.description,
    this.ecoCertified,
    this.groupSize,
    this.availableSpaces,
    // this.availableDates,
    this.address,
    this.geoloc,
    this.price,
    this.specialOffer,
    this.whatToBring,
    this.titleImage,
    this.galleryImages,
    this.itinerary,
    this.whatsIncluded,
    this.specials,
    this.covidMeasures,
    this.cancellationPolicy,
    this.rating,
    this.reviews,
  });

  factory DealModel.fromJson(Map<String, dynamic> data) =>
      _$DealModelFromJson(data);

  Map<String, dynamic> toJson() => _$DealModelToJson(this);
}

// Deals model
/// DealsModel controls a `Stream` of delas and handles
/// ...refreshing data and lazy loading
class DealsModel {
  final DatabaseManager _database = DatabaseManager();

  Stream<List<DealModel>>? stream;
  bool? hasMore;
  bool? _isLoading;
  List<DealModel> _data = [];
  StreamController<List<DealModel>>? _controller;
  List<String>? queryDocIDs;

  DealsModel({List<String>? queryDocIDs}) {
    this._data = [];
    this._controller = StreamController<List<DealModel>>.broadcast();
    this._isLoading = false;
    this.stream = _controller!.stream;
    this.hasMore = true;
    this.queryDocIDs = queryDocIDs;

    refresh();
  }

  Future<void> refresh() async {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      _data = [];
      hasMore = true;
    }
    if (_isLoading == true || hasMore == false) {
      return Future.value();
    }
    _isLoading = true;

    return _database
        .getDeals(queryDocIDs: queryDocIDs, limit: 10)
        .then((deals) {
      _isLoading = false;
      _data.addAll(deals);
      hasMore =
          (_data.length < 2); // TODO: Summe bekommen, ohne alle daten zu laden?
      _controller!.add(_data);
    });
  }
}
