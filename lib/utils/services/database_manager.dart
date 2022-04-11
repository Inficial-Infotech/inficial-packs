import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:packs/models/RatingModel.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:packs/utils/globals.dart' as globals;
// Services:
import 'package:packs/models/GeoPointModel.dart';
import 'package:packs/models/IconTitleTextModel.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/models/AddressModel.dart';
import 'package:packs/models/PriceModel.dart';
import 'package:packs/models/ReviewModel.dart';
import 'package:packs/models/StartEndDateModel.dart';

// Dummy:
// import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:faker/faker.dart';

// final geo = GeoFlutterFire();
final faker = new Faker();

class DatabaseManager {
  final userCollectionReference =
      FirebaseFirestore.instance.collection('user').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  final dealsCollectionReference = FirebaseFirestore.instance
      .collection('deals')
      .withConverter<DealModel>(
        fromFirestore: (snapshot, _) => DealModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  // User Data

  Future setUserData() async {
    return await userCollectionReference
        .doc(globals.currentUserData.uid)
        .set(globals.currentUserData);
  }

  Future<User?> getUserData({
    required String uid,
  }) async {
    User? userData;
    await userCollectionReference.doc(uid).get().then((snapshot) => {
          userData = snapshot.data(),
        });

    return userData;
  }

  // Deals Data

  Future<List<DealModel>> getDeals({
    List<String>? queryDocIDs,
    required int limit,
  }) async {
    List<DealModel>? deals = [];
    var ref = dealsCollectionReference.limit(limit);
    if (queryDocIDs != null) {
      ref = ref.where(FieldPath.documentId, whereIn: queryDocIDs);
    }

    await ref.get().then((snapshot) => {
          for (final doc in snapshot.docs)
            {
              deals.add(doc.data()),
            }
        });

    // TODO: Refactor
    for (var deal in deals) {
      final ref = FirebaseStorage.instance.ref().child(deal.titleImage!);
      final url = await ref.getDownloadURL();
      deal.titleImage = url;
    }

    return deals;
  }

  // static Future<List<String>> getDownloadLinks(List<Reference> refs) =>
  //     Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  // Get single deal ..

  // Company Data

  // MARK: - GENERATE DUMMY DATA
  // - Deals
  Future<void> setDummyDeeal() async {
    var uuid = Uuid().v1();

    int price = faker.randomGenerator.integer(10000);
    int? priceBeforeDiscount =
        faker.randomGenerator.boolean() ? (price * 1.12).round() : null;

    List<StartEndDateModel> availableDates = [];
    for (int i = 0; i < 3; i++) {
      DateTime startDate = faker.date.dateTime(minYear: 2021, maxYear: 2022);
      DateTime endDate = startDate.add(const Duration(days: 3));
      availableDates.add(
        StartEndDateModel(
          end: endDate,
          start: startDate,
        ),
      );
    }

    final itinerary = [
      for (final index in [0, 1, 2])
        IconTitleTextModel(
          title: 'ay $index - ${faker.lorem.word()}',
          text:
              '${faker.lorem.sentence()} Come join us in Australias favourite beach town for a day of good vibes, fun surf, delicious food and other outdoor adventures like kayaking with dolphins, coastal hikes and the beach bonfire night of your dreams.',
        ),
    ];

    final images = [
      'test-1.jpg',
      'test-2.jpg',
      'test-3.jpg',
      'test-3.jpg',
      'test-4.jpg',
      'test-5.jpg',
    ];

    final whatsIncluded = [
      for (final index in [1, 2, 3])
        IconTitleTextModel(
          icon: 'star',
          title:
              '${faker.lorem.word()} ${faker.lorem.word()} ${faker.lorem.word()} included',
          text: '${faker.lorem.sentence()}',
        ),
    ];

    final covidMeasures = [
      IconTitleTextModel(
        icon: 'hands-wash',
        title: 'Handsanitizer',
        text: 'Free Handsanitizer available at all times.',
      ),
      IconTitleTextModel(
        icon: 'clock',
        title: 'Handsanitizer',
        text: 'Free Handsanitizer available at all times.',
      ),
      IconTitleTextModel(
        icon: 'island-tropical',
        title: 'Handsanitizer',
        text: 'Free Handsanitizer available at all times.',
      )
    ];

    final specials = [
      for (final index in [0, 1, 2])
        IconTitleTextModel(
          title: '${faker.lorem.word().toUpperCase()} VIP Package',
          text:
              '${faker.lorem.sentence()} ${faker.lorem.sentence()} ${faker.lorem.sentence()}',
        ),
    ];

    final rating = [
      RatingModel(
          title: 'Value for Money',
          value: faker.randomGenerator.integer(50) / 100),
      RatingModel(
          title: 'Friendliness',
          value: faker.randomGenerator.integer(50) / 100),
      RatingModel(
          title: 'Overall Quality',
          value: faker.randomGenerator.integer(50) / 100),
      RatingModel(
          title: 'Would Recommend',
          value: faker.randomGenerator.integer(50) / 100),
    ];

    final reviews = [
      ReviewModel(
        title: faker.person.name(),
        text: faker.lorem.sentence() + faker.lorem.sentence(),
        value: (faker.randomGenerator.integer(50) / 10),
      ),
    ];

    final deal = DealModel(
      uid: uuid,
      active: true,
      // createdAt: DateTime.now(),
      category: 'day-trip',
      name: '${faker.sport.name()} Tour',
      description:
          '${faker.lorem.sentence()} ${faker.lorem.sentence()} ${faker.lorem.sentence()}',
      ecoCertified: faker.randomGenerator.boolean(),
      groupSize: faker.randomGenerator.integer(160, min: 5),
      availableSpaces: faker.randomGenerator.integer(5, min: 1),
      // availableDates: availableDates,
      address: AddressModel(
        buildingNumber: faker.address.buildingNumber(),
        street: faker.address.streetAddress(),
        city: faker.address.city(),
        zipCode: faker.address.zipCode(),
        state: faker.address.city(),
        country: faker.address.country(),
      ),
      geoloc: GeoPointModel(
        lat: faker.randomGenerator.integer(90).toDouble(),
        lng: faker.randomGenerator.integer(180).toDouble(),
      ),
      price: PriceModel(
          currency: 'AUD',
          priceBeforeDiscount: priceBeforeDiscount,
          value: price),
      specialOffer: faker.randomGenerator.boolean(),
      whatToBring: [
        faker.food.restaurant(),
        faker.food.restaurant(),
        faker.food.restaurant(),
        faker.food.restaurant(),
        faker.food.restaurant(),
        faker.food.restaurant(),
      ],
      titleImage: faker.randomGenerator.element(images),
      galleryImages: images,
      itinerary: itinerary,
      whatsIncluded: whatsIncluded,
      specials: specials,
      covidMeasures: covidMeasures,
      cancellationPolicy: IconTitleTextModel(
        title: '24h cancellation policy',
        text: 'Cancel up to 24 hours in advance to get a full refund.',
      ),
      rating: rating,
      reviews: reviews,
    );

    await dealsCollectionReference.doc(uuid).set(deal);
  }
}
