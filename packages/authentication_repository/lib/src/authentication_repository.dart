import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart' as Models;

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CacheClient _cache;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AuthenticationRepository({CacheClient? cache})
      : _cache = cache ?? CacheClient();
  static const String userCacheKey = '__user_cache_key__';

  Stream<Models.User?> get user {
    return _auth.authStateChanges().map((User? firebaseUser) {
      final Models.User? user = firebaseUser?.toUser;
      if (user != null) {
        _cache.write(key: userCacheKey, value: user);
      }
      return user;
    });
  }

  Future<String?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userPref = prefs.getString('packs-app-user');
    if (userPref != null) {
      return userPref;
    }
    return null;
    // return _cache.read<User>(key: userCacheKey) ?? null;
    // final user = _auth.currentUser;
    // if (user != null) {
    //   print('#### getCurrentUser: ${user.uid}');
    //   globals.currentUserData.uid = user.uid;
    //   return user;
    // } else {
    //   return null;
    // }
  }

  Future<void> convertUser({
    required String email,
    required String password,
  }) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.linkWithCredential(
          EmailAuthProvider.credential(email: email, password: password),
        );
      } on FirebaseException catch (e) {
        throw LogInWithEmailAndPasswordFailure(e.code);
      } catch (_) {
        throw const LogInWithEmailAndPasswordFailure();
      }
    }
  }

  Future<User> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw const LogInWithEmailAndPasswordFailure();
      }

      final User user = result.user!;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('packs-app-user', user.uid);
      _cache.write(key: userCacheKey, value: user);

      return user;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('packs-app-user');
      _cache.write(key: userCacheKey, value: null as String);
    } catch (e) {
      throw LogOutFailure();
    }
  }

  Future<User> signUpWithCredential(AuthCredential credential) async {
    try {
      final UserCredential result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        throw const LogInWithEmailAndPasswordFailure();
      }

      final User user = result.user!;
      _cache.write(key: userCacheKey, value: user);

      return user;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_, st) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<User> signInWithCredential(AuthCredential credential) async {
    try {
      final UserCredential result =
          await _auth.signInWithCredential(credential);
      if (result.user == null) {
        throw const LogInWithEmailAndPasswordFailure();
      }

      final User user = result.user!;
      _cache.write(key: userCacheKey, value: user);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('packs-app-user', user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
}

extension on User {
  Models.User get toUser {
    return Models.User(uid: uid, email: email, firstName: displayName);
  }
}
