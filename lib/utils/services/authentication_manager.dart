import 'package:firebase_auth/firebase_auth.dart';
import 'package:packs/utils/globals.dart' as globals;
// Services:
import 'package:packs/utils/services/database_manager.dart';
import 'package:user_repository/user_repository.dart' as UserRepo;

class AuthenticationManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current User

  User? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      print('#### getCurrentUser: ${user.uid}');
      globals.currentUserData.uid = user.uid;
      return user;
    } else {
      return null;
    }
  }

  // Sign In Anonymously

  Future signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      final user = result.user;

      if (user != null) {
        globals.currentUserData = UserRepo.User(
          firstName: globals.currentUserData.firstName,
          regionOfInterest: globals.currentUserData.regionOfInterest,
          uid: user.uid,
        );

        await DatabaseManager().setUserData();
      }
    } catch (e) {
      print(e);
    }
  }

  // Convert anonymous user to a permanent one

  Future convertUser({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user != null) {
      user.linkWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    }
  }

  // Register with email and password

  // Future registerUserWithEmailAndPassword({
  //   String email,
  //   String password,
  // }) async {
  //   try {
  //     final result = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     if (result != null) {
  //       FirebaseUser user = result.user;
  //
  //       await DatabaseManager().setUserData(
  //         model: UserModel(
  //           uid: user.uid,
  //           email: user.email,
  //         ),
  //       );
  //       return user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Sign In with email and password

  Future signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user!;
      return user;
    } catch (e) {
      print(e);
    }
  }

  // Sign out

  Future signOut() async {
    try {
      await _auth.signOut();
      globals.currentUserData = UserRepo.User();
    } catch (e) {
      print(e);
    }
  }
}
