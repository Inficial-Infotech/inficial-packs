part of 'login_cubit.dart';

enum LoginType {
  phone,
  email,
  google,
}

enum LoginSteps { chooseType, generateOtp, verifyOtp }

class LoginState extends Equatable {
  LoginState(
      {this.email = '',
        this.phone = '',
        this.phoneCode = '',
        this.name = '',
        required this.country,
        this.loading = false,
        this.smsCode = '',
        required this.countries,
        this.emailCode = '',
        this.loginType = LoginType.phone,
        this.step = LoginSteps.chooseType,
        required this.otp,
        this.verificationId = '',
        required this.countryExploring,
        this.userId = ''});

  String email;
  final String phone;
  final String name;
  final Country country;
  final bool loading;
  final List<Country> countries;
  final String smsCode;
  LoginType loginType;
  final String emailCode;
  final LoginSteps step;
  String userId;
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
    loginType,
    smsCode,
    loading,
    emailCode,
    step,
    userId,
    otp,
    verificationId,
    countryExploring,
  ];

  LoginState copyWith(
      {String? email,
        String? phone,
        String? name,
        Country? country,
        List<Country>? countries,
        String? smsCode,
        LoginType? loginType,
        bool? loading,
        String? emailCode,
        LoginSteps? step,
        List<String>? otp,
        String? verificationId,
        Country? countryExploring,
        String? userId}) {
    return LoginState(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        countries: countries ?? this.countries,
        country: country ?? this.country,
        smsCode: smsCode ?? this.smsCode,
        loginType: loginType ?? this.loginType,
        emailCode: emailCode ?? this.emailCode,
        loading: loading ?? this.loading,
        userId: userId ?? this.userId,
        otp: otp ?? this.otp,
        verificationId: verificationId ?? this.verificationId,
        countryExploring: countryExploring ?? this.countryExploring,
        step: step ?? this.step);
  }
}
