import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/login/cubit/login_cubit.dart';
import 'package:packs/core/repositories/login_repository.dart';
import 'package:packs/models/country_model.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/widgets/components/back_button.dart';
import 'package:packs/widgets/components/flag.dart';
import 'package:packs/widgets/components/otp_text_field.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/user_repository.dart' as user_repo;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (BuildContext buildContext, LoginState state) {
          final LoginCubit cubit = context.read<LoginCubit>();
          return SafeArea(
            child: SingleChildScrollView(
              child: state.step != LoginSteps.verifyOtp
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: PXSpacing.spacingL,
                            right: PXSpacing.spacingL),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: PXSpacing.spacingXXL),
                            Row(
                              mainAxisAlignment:
                                  state.step == LoginSteps.generateOtp
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.end,
                              children: <Widget>[
                                if (state.step == LoginSteps.generateOtp)
                                  PXBackButton(
                                    colour: PXColor.black,
                                    onPressed: () {
                                      cubit.loginStepChanged(
                                          LoginSteps.chooseType);
                                    },
                                  )
                                else
                                  Container(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(CupertinoIcons.clear,
                                      color: PXColor.black, size: 30),
                                ),
                              ],
                            ),
                            const SizedBox(height: PXSpacing.spacingXXL),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Welcome back!',
                                  style: TextStyle(
                                      fontSize: PXFontSize.sizeXXL,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: PXSpacing.spacingL),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  state.step == LoginSteps.generateOtp
                                      ? 'Log in with your ${state.loginType == LoginType.phone ? 'phone number' : 'email'} '
                                      : 'Log in with your email or phone number',
                                  style: const TextStyle(
                                    color: PXColor.grey,
                                    fontSize: PXFontSize.body,
                                  )),
                            ),
                            const SizedBox(height: PXSpacing.spacingXXL),
                            if (state.loginType == LoginType.phone)
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Flag(
                                          country: state.country,
                                          rounded: true,
                                        ),
                                        onTap: () {
                                          _showPicker(context, state.countries,
                                              state.country, (Country country) {
                                            cubit.countyChanged(country);
                                          });
                                        },
                                      ),
                                      const SizedBox(width: PXSpacing.spacingS),
                                      const Icon(
                                        CupertinoIcons.chevron_down,
                                        size: PXFontSize.headline,
                                        color: PXColor.black,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: PXSpacing.spacingS),
                                  Text(
                                    state.country.dialCode ?? '',
                                  ),
                                  const SizedBox(width: PXSpacing.spacingS),
                                  Expanded(
                                    child: CupertinoTextField(
                                        onSubmitted: (String e) {},
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                style: BorderStyle.none)),
                                        placeholder: 'Your Phone Number',
                                        onChanged: (String value) {
                                          cubit.phoneChanged(value);
                                        }),
                                  )
                                ],
                              )
                            else
                              Row(
                                children: <Widget>[
                                  const Icon(CupertinoIcons.mail,
                                      color: PXColor.black),
                                  const SizedBox(width: PXSpacing.spacingS),
                                  Expanded(
                                    child: CupertinoTextField(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              style: BorderStyle.none)),
                                      placeholder: 'Email',
                                      onChanged: (String val) {
                                        cubit.emailChanged(val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            const Divider(
                              height: 10,
                            ),
                            const SizedBox(height: PXSpacing.spacingL),
                            if (state.step == LoginSteps.chooseType)
                              Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.loginTypeChanged(
                                        state.loginType == LoginType.phone
                                            ? LoginType.email
                                            : LoginType.phone);
                                  },
                                  child: Text(
                                      'use ${state.loginType == LoginType.email ? 'phone' : 'email'} instead',
                                      style: const TextStyle(
                                          fontSize: PXFontSize.body,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            else
                              Container(),
                            const SizedBox(height: PXSpacing.spacingXXL),
                            if (state.step == LoginSteps.chooseType)
                              Center(
                                child: Column(children: const <Widget>[
                                  Text('or continue with')
                                ]),
                              )
                            else
                              Container(),
                            const SizedBox(height: PXSpacing.spacingL),
                            if (state.step == LoginSteps.chooseType)
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: PXColor.athensGrey),
                                          borderRadius: BorderRadius.circular(
                                              PXBorderRadius.radiusXXL),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset(
                                                'assets/images/mac.png')),
                                      ),
                                      const SizedBox(width: PXSpacing.spacingS),
                                      GestureDetector(
                                        onTap: () async {
                                          final GoogleSignInAccount?
                                              googleUser =
                                              await googleSignIn.signIn();
                                          if (googleUser == null) return;
                                          state.email = googleUser.email;
                                          state.userId = googleUser.id;

                                          final GoogleSignInAuthentication
                                              googleAuth =
                                              await googleUser.authentication;
                                          final OAuthCredential credential =
                                              GoogleAuthProvider.credential(
                                                  idToken: googleAuth.idToken,
                                                  accessToken:
                                                      googleAuth.accessToken);
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: googleUser.email,
                                                    password: 'STATIC_PWD');
                                            final user_repo.User? user =
                                                await _userRepository
                                                    .getUserData(
                                                        uid: googleUser.id);
                                            globals.currentUserData = user!;
                                          } catch (e) {
                                            if (e.toString().contains(
                                                '[firebase_auth/wrong-password]')) {
                                              await FirebaseAuth.instance
                                                  .signInWithCredential(
                                                      credential);
                                              final user_repo.User? user =
                                                  await _userRepository
                                                      .getUserData(
                                                          uid: googleUser.id);
                                              globals.currentUserData = user!;
                                            } else {
                                              showFailureSnackBar(
                                                  'User not found');
                                            }
                                          }

                                          state.loginType = LoginType.google;
                                          navigateToSelectNameScreen(context);
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: PXColor.athensGrey),
                                            borderRadius: BorderRadius.circular(
                                                PXBorderRadius.radiusXXL),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  PXSpacing.spacingS),
                                              child: Image.asset(
                                                  'assets/images/google.png')),
                                        ),
                                      ),
                                      const SizedBox(width: PXSpacing.spacingS),
                                      GestureDetector(
                                        onTap: () async {
                                          _facebookLogin(state);
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: PXColor.athensGrey),
                                            borderRadius: BorderRadius.circular(
                                                PXBorderRadius.radiusXXL),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  PXSpacing.spacingS),
                                              child: Image.asset(
                                                  'assets/images/fb.png')),
                                        ),
                                      ),
                                    ],
                                  ))
                            else
                              Container(),
                            const SizedBox(height: PXSpacing.spacingL),
                            if (state.step == LoginSteps.chooseType)
                              CupertinoButton.filled(
                                  onPressed: state.loading
                                      ? null
                                      : () async {
                                          cubit.setLoading(true);
                                          if (state.loginType ==
                                              LoginType.phone) {
                                            final bool isPhoneExists =
                                                await cubit.isPhoneNumberExisting(
                                                    '${state.country.dialCode}${state.phone}');
                                            if (isPhoneExists) {
                                              cubit.loginStepChanged(
                                                  LoginSteps.generateOtp);
                                            } else {
                                              showFailureSnackBar(
                                                  'Phone number is not registered');
                                            }
                                          } else {
                                            final bool isEmailExists =
                                                await cubit
                                                    .checkIfEmailIsExists();
                                            if (!isEmailExists) {
                                              showFailureSnackBar(
                                                  'Email is not registered');
                                            } else {
                                              cubit.loginStepChanged(
                                                  LoginSteps.generateOtp);
                                            }
                                          }
                                        },
                                  child: state.loading
                                      ? const CupertinoActivityIndicator(
                                          color: PXColor.black,
                                        )
                                      : const Text('Login')),
                            if (state.step == LoginSteps.generateOtp)
                              CupertinoButton.filled(
                                onPressed: state.loading
                                    ? null
                                    : () async {
                                        if (state.loginType ==
                                            LoginType.email) {
                                          showSuccessSnackBar(
                                              'A code has been sent to ${state.email}');

                                          cubit.loginStepChanged(
                                              LoginSteps.verifyOtp);
                                        } else {
                                          cubit.setLoading(true);
                                          verifyPhoneNumber(
                                              '${state.country.dialCode}${state.phone}',
                                              context,
                                              state,
                                              cubit);
                                        }
                                      },
                                child: state.loading
                                    ? const CupertinoActivityIndicator(
                                        color: PXColor.white,
                                      )
                                    : const Text('Get code'),
                              )
                            else
                              Container(),
                            if (state.step == LoginSteps.chooseType)
                              SizedBox(
                                height: 80,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  color: PXColor.black,
                                  width: 120,
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: PXSpacing.spacingXXL),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              PXBackButton(
                                colour: PXColor.black,
                                onPressed: () {
                                  if (state.step == LoginSteps.generateOtp) {
                                    cubit.loginStepChanged(
                                        LoginSteps.chooseType);
                                  } else if (state.step ==
                                      LoginSteps.verifyOtp) {
                                    cubit.loginStepChanged(
                                        LoginSteps.generateOtp);
                                  }
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(CupertinoIcons.clear,
                                    color: PXColor.black, size: 30),
                              ),
                            ],
                          ),
                          const SizedBox(height: PXSpacing.spacingXXL),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                '${state.loginType == LoginType.email ? 'Email' : 'Phone'} Verification',
                                style: const TextStyle(
                                    fontSize: PXFontSize.sizeXXL,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: PXSpacing.spacingL),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Please enter the 6-digit code sent to you at ${state.loginType == LoginType.email ? state.email : '${state.country.dialCode}${state.phone}'}',
                                style: const TextStyle(
                                  color: PXColor.grey,
                                  fontSize: PXFontSize.body,
                                )),
                          ),
                          const SizedBox(height: PXSpacing.spacingXXL),
                          Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: <Widget>[
                                OtpTextField(
                                    onChangeField: (String value, int index) {
                                  cubit.setOtpNumber(value, index);
                                }),
                                const SizedBox(height: PXSpacing.spacingL),
                                Center(
                                  child: GestureDetector(
                                    child: const Text(
                                      'Resend Code',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                    onTap: () async {
                                      if (state.loginType == LoginType.phone) {
                                        cubit.setLoading(true);
                                        verifyPhoneNumber(
                                            '${state.country.dialCode}${state.phone}',
                                            context,
                                            state,
                                            cubit);
                                      } else {
                                        cubit.setLoading(true);
                                        final bool isEmailExists =
                                            await cubit.checkIfEmailIsExists();
                                        cubit.setLoading(false);
                                        if (!isEmailExists) {
                                          showFailureSnackBar(
                                              'Email is not registered');
                                        } else {
                                          showSuccessSnackBar(
                                              'A code has been sent to ${state.email}');
                                        }
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: PXSpacing.spacingXL),
                                if (state.loginType == LoginType.email)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Text(
                                          'We’ve sent you a new code. Don’t forget to check your junk folder!'),
                                    ),
                                  )
                                else
                                  Container(),
                                const SizedBox(height: PXSpacing.spacingL),
                                Center(
                                  child: CupertinoButton.filled(
                                    onPressed: state.loading
                                        ? null
                                        : () async {
                                            final bool isEmpty = state.otp.any(
                                                (String element) =>
                                                    element.isEmpty);
                                            if (isEmpty) {
                                              return;
                                            }
                                            cubit.setLoading(true);
                                            if (state.loginType ==
                                                LoginType.phone) {
                                              final String? id = await context
                                                  .read<LoginRepository>()
                                                  .verifyPhoneOtp(
                                                      state.otp.join(),
                                                      state.verificationId);
                                              if (id == null) {
                                                showFailureSnackBar(
                                                    'Invalid code');
                                              } else {
                                                Navigator.pop(context);
                                                navigateToSelectNameScreen(
                                                    context);
                                              }
                                              cubit.setLoading(false);
                                            } else {
                                              if (state.emailCode.toString() ==
                                                  state.otp.join()) {
                                                try {
                                                  final UserCredential d =
                                                      await _auth
                                                          .signInWithEmailAndPassword(
                                                              email:
                                                                  state.email,
                                                              password:
                                                                  'STATIC_PWD');
                                                  cubit.setLoading(false);
                                                  navigateToSelectNameScreen(
                                                      context);
                                                } catch (e) {
                                                  try {
                                                    final UserCredential data =
                                                        await _auth
                                                            .createUserWithEmailAndPassword(
                                                                email:
                                                                    state.email,
                                                                password:
                                                                    'STATIC_PWD');
                                                    navigateToSelectNameScreen(
                                                        context);
                                                  } catch (e) {
                                                    cubit.setLoading(false);
                                                  } finally {
                                                    cubit.setLoading(false);
                                                  }
                                                }
                                              } else {
                                                cubit.setLoading(false);
                                                showFailureSnackBar(
                                                    'Invalid code');
                                              }
                                            }
                                          },
                                    child: state.loading
                                        ? const CupertinoActivityIndicator(
                                            color: PXColor.white)
                                        : const Text('Submit'),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _facebookLogin(LoginState state) async {
    final FacebookLoginResult res = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        final String token = accessToken?.token ?? '';
        log('face book access token : $token');
        log('face book access token2: ${await facebookLogin.accessToken}');

        final FacebookUserProfile? profile =
            await facebookLogin.getUserProfile();
        final String? userProfile = profile?.userId;
        final String? userName = profile?.name;

        final String? email = await facebookLogin.getUserEmail();
        if (email != null) final String userEmail = email;
        state.email = email!;
        state.name = userName!;
        state.userId = profile!.userId;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(token);

        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: 'STATIC_PWD');
        } catch (e) {
          if (e.toString().contains('[firebase_auth/wrong-password]')) {
            await FirebaseAuth.instance.signInWithCredential(credential);
          } else {
            showFailureSnackBar('User not found');
          }
        }

        state.loginType = LoginType.facebook;
        navigateToSelectNameScreen(context);
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        log('Error while log in: ${res.error}');
        break;
    }
  }

  void verificationFailed(
      FirebaseAuthException authException, BuildContext ctx) {
    showFailureSnackBar(
      'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context,
      LoginState state, LoginCubit cubit) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(minutes: 2),
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException authException) {
            cubit.setLoading(false);
            verificationFailed(authException, context);
          },
          codeSent: (String code, int? i) {
            cubit.setLoading(false);
            showSuccessSnackBar(
                'A code has been sent to ${state.country.dialCode}${state.phone}');
            cubit.setVerificationId(code);
            cubit.loginStepChanged(LoginSteps.verifyOtp);
          },
          codeAutoRetrievalTimeout: (String id) {
            cubit.setVerificationId(id);
          });
    } catch (e) {
      showFailureSnackBar('Failed to Verify Phone Number: $e');
    }
  }
}

void _showPicker(BuildContext ctx, List<Country> countries, Country? country,
    Function(Country) onSave) {
  int index = countries.indexOf(country!);
  showCupertinoModalPopup(
      context: ctx,
      builder: (BuildContext context) => CupertinoActionSheet(
            actions: <Widget>[
              SizedBox(
                height: 250,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 60,
                  scrollController:
                      FixedExtentScrollController(initialItem: index),
                  children: <Widget>[
                    for (Country item in countries)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(width: PXSpacing.spacingS),
                          Flag(
                            country: item,
                          ),
                          const SizedBox(width: PXSpacing.spacingM),
                          Text(
                            item.dialCode ?? '',
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                  ],
                  onSelectedItemChanged: (int value) {
                    index = value;
                  },
                ),
              ),
              CupertinoActionSheetAction(
                child: const Text('Save'),
                onPressed: () {
                  onSave.call(countries.elementAt(index));
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              )
            ],
          ));
}

void showFailureSnackBar(String message) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: PXColor.red,
      textColor: PXColor.white);
}

void navigateToSelectNameScreen(BuildContext context) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (BuildContext ctx) => RepositoryProvider<LoginRepository>.value(
        value: context.read<LoginRepository>(),
        child: BlocProvider<LoginCubit>.value(
          value: BlocProvider.of<LoginCubit>(context),
          child: HomeScreen(),
        ),
      ),
    ),
  );
}

void showSuccessSnackBar(String message) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: PXColor.black,
      textColor: PXColor.white);
}
