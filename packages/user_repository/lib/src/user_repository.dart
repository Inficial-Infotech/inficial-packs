import 'package:cloud_firestore/cloud_firestore.dart';

import './models/models.dart' as Models;

class UserRepository {
  final userCollectionReference = FirebaseFirestore.instance
      .collection('user')
      .withConverter<Models.User>(
        fromFirestore: (snapshot, _) => Models.User.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Future setUserData(Models.User user) async {
    return await userCollectionReference.doc(user.uid).set(user);
  }

  Future<Models.User?> getUserData({
    required String uid,
  }) async {
    Models.User? userData;
    await userCollectionReference.doc(uid).get().then((snapshot) => {
          userData = snapshot.data(),
        });

    return userData;
  }
}
