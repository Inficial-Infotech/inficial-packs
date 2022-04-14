import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:packs/api/rest_api_service.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:user_repository/user_repository.dart' as user_repo;

class SignupRepository {
  SignupRepository(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;
  final user_repo.UserRepository _userRepository = user_repo.UserRepository();

  Future<String> getEmailCode(String email) async {
    final Response result =
        await RestApiService().get('mobile-app/email-verification/$email');
    if (result.statusCode == 200) {
      return json.decode(result.body)['data']['result'].toString();
    }
    return '';
  }

  Future<bool> checkIfPhoneAlreadyRegistered(String phone) async {
    final Response result = await RestApiService().get('signup/phone/$phone');
    if (result.statusCode == 200) {
      return json.decode(result.body)['data']['result'] as bool;
    }
    return false;
  }

  Future<bool> signup(
      String email,
      String name,
      String phone,
      String uid,
      String countryOfInterest,
      bool isPhone,
      String smsCode,
      String verificationId,
      String emailCode,int provider) async {
    // String? userId;
    // if (!isPhone) {
    //   try {
    //     await _authenticationRepository.signOut();
    //   } catch (e) {
    //     print('Error 1: $e');
    //   }
    //   try {
    //     final User user = await _authenticationRepository.signInUserWithEmailAndPassword(email: email, password: 'STATIC_PWD');
    //     userId = user.uid;
    //   } catch (e) {
    //     print('Error 2: $e');
    //   }
    //   if (userId == null) {
    //     return false;
    //   }
    // }

    final Response result =
        await RestApiService().post('mobile-app/mobille-signup', {
      'email': email,
      'phone': phone,
      'uid': uid,
      'countryOfInterest': countryOfInterest,
      'name': name,
      'provider' : provider
    });
    if (result.statusCode == 200) {
      final user_repo.User? user = await _userRepository.getUserData(uid: uid);
      globals.currentUserData = user!;
      return true;
    } else {
      return false;
    }
  }

  Future<String?> verifyPhoneOtp(String code, String verificationId) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
    try {
      final User user =
          await _authenticationRepository.signUpWithCredential(credential);
      return user.uid;
    } catch (e) {
      return null;
    }
  }
}
