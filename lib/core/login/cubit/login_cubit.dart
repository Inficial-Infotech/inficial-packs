import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:packs/api/rest_api_service.dart';
import 'package:packs/core/signup/signup_provider.dart';
import 'package:packs/models/country_list.dart';
import 'package:packs/models/country_model.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:user_repository/user_repository.dart' as user_repo;

part 'login_state.dart';

class EmailResponse {
  String code;
  String uid;

  EmailResponse(this.code, this.uid);
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : super(
          LoginState(
            country: SignupProvider().getCountriesData().first,
            countries: [],
            countryExploring: SignupProvider().getCountriesData().first,
            otp: [
              '',
              '',
              '',
              '',
              '',
              '',
            ],
          ),
        );

  final AuthenticationRepository _authenticationRepository;
  final user_repo.UserRepository _userRepository = user_repo.UserRepository();

  void loadCountries(String code) {
    final List<Country> countries = Countries.countryList.map((Map<String, dynamic> country) => Country.fromJson(country)).toList();
    final Country country = countries.firstWhere((Country country) => country.alpha2Code == code, orElse: () => countries[0]);
    emit(state.copyWith(country: country, countries: countries));
  }

  void emailChanged(String email) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void loginStepChanged(LoginSteps step) {
    emit(
      state.copyWith(step: step),
    );
  }

  void loginTypeChanged(LoginType type) {
    emit(
      state.copyWith(loginType: type),
    );
  }

  void countyChanged(Country value) {
    emit(
      state.copyWith(
        country: value,
      ),
    );
  }

  void phoneChanged(String value) {
    emit(
      state.copyWith(
        phone: value,
      ),
    );
  }

  void setEmailCode(String value) {
    emit(
      state.copyWith(
        emailCode: value,
      ),
    );
  }

  void setLoading(bool value) {
    emit(
      state.copyWith(
        loading: value,
      ),
    );
  }

  void setVerificationId(String id) {
    emit(
      state.copyWith(
        verificationId: id,
      ),
    );
  }

  void setOtpNumber(String number, int index) {
    List<String> otp = state.otp;
    otp[index] = number;
    emit(
      state.copyWith(
        otp: otp,
      ),
    );
  }

  Future<bool> isPhoneNumberExisting(String phone) async {
    emit(
      state.copyWith(loading: true),
    );
    final Response result = await RestApiService().get('signup/phone/$phone');
    emit(
      state.copyWith(
        loading: false,
      ),
    );
    if (result.statusCode == 200) {
      return json.decode(result.body)['data']['result'] as bool;
    }
    return false;
  }

  Future<bool> checkIfEmailIsExists() async {
    emit(
      state.copyWith(loading: true),
    );
    final Response result = await RestApiService().post('mobile-app/email/login', {'email': state.email});

    emit(
      state.copyWith(
        loading: false,
      ),
    );
    if (result.statusCode == 200) {
      var data = json.decode(result.body)['data'];
      emit(
        state.copyWith(
          emailCode: (data['code']).toString(),
          userId: data['uid'] as String,
        ),
      );
      return true;
    }
    return false;
  }

  Future<bool> logInWithCredentials() async {
    try {
      final User user = await _authenticationRepository.signInUserWithEmailAndPassword(
        email: state.email,
        password: 'STATIC_PWD',
      );
      final user_repo.User? usr = await _userRepository.getUserData(uid: user.uid);
      globals.currentUserData = usr!;
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> verifyPhoneOtp() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: state.verificationId,
      smsCode: state.otp.join(),
    );
    try {
      final User user =
          await _authenticationRepository.signInWithCredential(credential);
      final user_repo.User? usr =
          await _userRepository.getUserData(uid: user.uid);
      globals.currentUserData = usr!;
      return user.uid;
    } catch (e) {
      return null;
    }
  }

  bool verifyEmailCode() {
    return state.emailCode == state.otp.join();
  }
}
