import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:packs/api/rest_api_service.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  LoginRepository(this._auth);

  final AuthenticationRepository _auth;

  Future<User> sigIn(String email, String password) async {
    return _auth.signInUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> getEmailCode(String email) async {
    final Response result =
        await RestApiService().get('mobile-app/email-verification/$email');
    if (result.statusCode == 200) {
      return json.decode(result.body)['data']['result'].toString();
    }
    return '';
  }

  Future<bool> signInWithPhone(String phone, {String uid = ''}) async {
    try {
      final Response result = await RestApiService()
          .post('mobile-app/phone/login', {'phone': phone});
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      return false;
    }
  }

  Future<String> signInWithEmail(String email, {String uid = ''}) async {
    try {
      final Response result = await RestApiService()
          .post('mobile-app/email/login', {'email': email});
      if (result.statusCode == 200) {
        String userId = json.decode(result.body)['data']['uid'].toString();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('packs-app-user', userId);
        globals.currentUserData.uid = userId;
        return json.decode(result.body)['data']['uid'].toString();
      }
      return '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<String?> verifyPhoneOtp(String code, String verificationId) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
    try {
      final User user = await _auth.signInWithCredential(credential);
      return user.uid;
    } catch (e) {
      return null;
    }
  }
}
