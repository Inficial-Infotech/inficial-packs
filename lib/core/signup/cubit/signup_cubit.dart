import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/core/signup/signup_provider.dart';
import 'package:packs/models/country_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit()
      : super(
          SignupState(
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

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
      ),
    );
  }

  void loadCountries(String code) {
    final List<Country> countries = SignupProvider().getCountriesData();
    final Country country = countries.firstWhere(
        (Country country) => country.alpha2Code == code,
        orElse: () => countries[0]);
    emit(state.copyWith(
        country: country, countries: countries, countryExploring: country));
  }

  void phoneChanged(String value) {
    emit(
      state.copyWith(
        phone: value,
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: value,
      ),
    );
  }

  void countyChanged(Country value) {
    emit(
      state.copyWith(
        country: value,
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

  void setSmsCode(String smsCode) {
    emit(
      state.copyWith(
        smsCode: smsCode,
      ),
    );
  }

  void setEmailCode(String emailCode) {
    emit(
      state.copyWith(
        emailCode: emailCode,
      ),
    );
  }

  void signupTypeChanged(SignupType type) {
    emit(
      state.copyWith(
        signupType: type,
      ),
    );
  }

  void signupStepChanged(SignupSteps step) {
    emit(
      state.copyWith(
        step: step,
      ),
    );
  }

  void setUserId(String uId) {
    emit(
      state.copyWith(
        userId: uId,
      ),
    );
  }

  void setOtpNumber(String number, int index) {
    // ignore: prefer_final_locals
    List<String> otp = state.otp;
    otp[index] = number;
    emit(
      state.copyWith(
        otp: otp,
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

  void exploringCountryChanged(Country country) {
    emit(
      state.copyWith(
        countryExploring: country,
      ),
    );
  }
}
