part of 'signup_cubit.dart';

enum SignupType { phone, email, google }

enum SignupSteps { chooseType, generateOtp, verifyOtp }

class SignupState extends Equatable {
  SignupState(
      {this.email = '',
      this.phone = '',
      this.phoneCode = '',
      this.name = '',
      required this.country,
      this.loading = false,
      this.smsCode = '',
      required this.countries,
      this.emailCode = '',
      this.signupType = SignupType.phone,
      this.step = SignupSteps.chooseType,
      required this.otp,
      this.verificationId = '',
      required this.countryExploring,
      this.userId = ''});

  final String email;
  final String phone;
  final String name;
  final Country country;
  final bool loading;
  final List<Country> countries;
  final String smsCode;
  final SignupType signupType;
  final String emailCode;
  final SignupSteps step;
  final String userId;
  final List<String> otp;
  final String verificationId;
  final String phoneCode;
  final Country countryExploring;

  @override
  List<Object> get props => [
        email,
        phone,
        name,
        countries,
        country,
        signupType,
        smsCode,
        loading,
        emailCode,
        step,
        userId,
        otp,
        verificationId,
        countryExploring,
      ];

  SignupState copyWith(
      {String? email,
      String? phone,
      String? name,
      Country? country,
      List<Country>? countries,
      String? smsCode,
      SignupType? signupType,
      bool? loading,
      String? emailCode,
      SignupSteps? step,
      List<String>? otp,
      String? verificationId,
      Country? countryExploring,
      String? userId}) {
    return SignupState(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        countries: countries ?? this.countries,
        country: country ?? this.country,
        smsCode: smsCode ?? this.smsCode,
        signupType: signupType ?? this.signupType,
        emailCode: emailCode ?? this.emailCode,
        loading: loading ?? this.loading,
        userId: userId ?? this.userId,
        otp: otp ?? this.otp,
        verificationId: verificationId ?? this.verificationId,
        countryExploring: countryExploring ?? this.countryExploring,
        step: step ?? this.step);
  }
}
