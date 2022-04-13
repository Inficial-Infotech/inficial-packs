import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/login/login_screen.dart';
import 'package:packs/core/repositories/signup_repository.dart';
import 'package:packs/core/signup/cubit/signup_cubit.dart';
import 'package:packs/core/signup/select_name.dart';
import 'package:packs/models/country_model.dart';
import 'package:packs/widgets/components/back_button.dart';
import 'package:packs/widgets/components/otp_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (BuildContext buildContext, SignupState state) {
          final SignupCubit cubit = context.read<SignupCubit>();
          return SafeArea(
            child: SingleChildScrollView(
              child: state.step != SignupSteps.verifyOtp
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: PXSpacing.spacingL, right: PXSpacing.spacingL),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: PXSpacing.spacingXXL),
                      Row(
                        mainAxisAlignment: state.step == SignupSteps.generateOtp ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                        children: <Widget>[
                          if (state.step == SignupSteps.generateOtp)
                            PXBackButton(
                              colour: PXColor.black,
                              onPressed: () {
                                cubit.signupStepChanged(SignupSteps.chooseType);
                              },
                            )
                          else
                            Container(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              CupertinoIcons.clear,
                              color: PXColor.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PXSpacing.spacingXXL),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Let\'s get started!', style: TextStyle(fontSize: PXFontSize.sizeXXL, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: PXSpacing.spacingL),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          state.step == SignupSteps.generateOtp
                              ? 'Signup with your ${state.signupType == SignupType.phone ? 'phone' : 'email'} number'
                              : 'Signup with your email or phone number',
                          style: const TextStyle(
                            color: PXColor.grey,
                            fontSize: PXFontSize.body,
                          ),
                        ),
                      ),
                      const SizedBox(height: PXSpacing.spacingXXL),
                      if (state.signupType == SignupType.phone)
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: _Flag(
                                    country: state.country,
                                  ),
                                  onTap: () {
                                    _showPicker(context, state.countries, state.country, (Country selected) {
                                      cubit.countyChanged(selected);
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
                                // controller: phoneController,
                                  onSubmitted: (String e) {},
                                  decoration: BoxDecoration(border: Border.all(style: BorderStyle.none)),
                                  // keyboardType: TextInputType.phone,
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
                            const Icon(
                              CupertinoIcons.mail,
                              color: PXColor.black,
                            ),
                            const SizedBox(width: PXSpacing.spacingS),
                            Expanded(
                              child: CupertinoTextField(
                                // keyboardType: TextInputType.emailAddress,
                                decoration: BoxDecoration(border: Border.all(style: BorderStyle.none)),
                                placeholder: 'Email',
                                onChanged: (String val) {
                                  cubit.emailChanged(val);
                                },
                              ),
                            ),
                          ],
                        ),
                      const Divider(
                        height: PXSpacing.spacingM,
                      ),
                      const SizedBox(height: PXSpacing.spacingL),
                      if (state.step == SignupSteps.chooseType)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: GestureDetector(
                              onTap: () {
                                cubit.signupTypeChanged(state.signupType == SignupType.phone ? SignupType.email : SignupType.phone);
                              },
                              child: Text(
                                'use ${state.signupType == SignupType.email ? 'phone' : 'email'} instead',
                                style: const TextStyle(fontSize: PXFontSize.body, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: PXSpacing.spacingXXL),
                      if (state.step == SignupSteps.chooseType)
                        Center(
                          child: Column(children: const <Widget>[Text('or continue with')]),
                        )
                      else
                        Container(),
                      const SizedBox(height: PXSpacing.spacingL),
                      if (state.step == SignupSteps.chooseType)
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PXColor.athensGrey),
                                    borderRadius: BorderRadius.circular(PXBorderRadius.radiusXXL),
                                  ),
                                  child:
                                  Padding(padding: const EdgeInsets.all(PXSpacing.spacingS), child: Image.asset('assets/images/mac.png')),
                                ),
                                const SizedBox(width: PXSpacing.spacingS),
                                GestureDetector(
                                  onTap: () async {
                                    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                                    if (googleUser == null) {
                                      return;
                                    }
                                    cubit.emailChanged(googleUser.email);
                                    cubit.setUserId(googleUser.id);

                                    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                                    final OAuthCredential credential =
                                    GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: googleUser.email,password: "STATIC_PWD").catchError((e) {
                                      if (e.toString().contains("firebase_auth/email-already-in-use")) {
                                        showFailureSnackBar('Email is already associated with other account');
                                      }
                                    });
                                    cubit.signupTypeChanged(SignupType.google);
                                    navigateToSelectNameScreen(context);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PXColor.athensGrey),
                                      borderRadius: BorderRadius.circular(PXBorderRadius.radiusXXL),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(PXSpacing.spacingS), child: Image.asset('assets/images/google.png')),
                                  ),
                                ),
                                const SizedBox(width: PXSpacing.spacingS),
                                GestureDetector(
                                  onTap: () async {
                                    _fabebookLogin(cubit);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PXColor.athensGrey),
                                      borderRadius: BorderRadius.circular(PXBorderRadius.radiusXXL),
                                    ),
                                    child:
                                    Padding(padding: const EdgeInsets.all(PXSpacing.spacingS), child: Image.asset('assets/images/fb.png')),
                                  ),
                                ),
                              ],
                            ))
                      else
                        Container(),
                      const SizedBox(height: PXSpacing.spacingL),
                      if (state.step == SignupSteps.chooseType)
                        CupertinoButton.filled(
                            onPressed: state.loading
                                ? null
                                : () async {
                              cubit.setLoading(true);

                              if (state.signupType == SignupType.phone) {
                                try {
                                  final bool isExists = await context
                                      .read<SignupRepository>()
                                      .checkIfPhoneAlreadyRegistered('${state.country.dialCode!}${state.phone}');
                                  if (isExists) {
                                    showSnackBar('Phone number is already associated with other account', context);
                                  } else {
                                    cubit.signupStepChanged(SignupSteps.generateOtp);
                                  }
                                } catch (e) {
                                  print(e);
                                } finally {
                                  cubit.setLoading(false);
                                }
                              } else {
                                try {
                                  final String code = await context.read<SignupRepository>().getEmailCode(state.email);
                                  if (code.isNotEmpty) {
                                    cubit.setEmailCode(code);
                                    cubit.signupStepChanged(SignupSteps.generateOtp);
                                  } else {
                                    showSnackBar('Email is already associated with other account', context);
                                  }
                                } catch (e) {
                                  showSnackBar('Email is already associated with other account', context);
                                } finally {
                                  cubit.setLoading(false);
                                }
                              }
                            },
                            child: state.loading
                                ? const CupertinoActivityIndicator(
                              color: PXColor.black,
                            )
                                : const Text('Sign up')),
                      if (state.step == SignupSteps.generateOtp)
                        CupertinoButton.filled(
                          onPressed: state.loading
                              ? null
                              : () async {
                            if (state.signupType == SignupType.phone) {
                              verifyPhoneNumber('${state.country.dialCode!}${state.phone}', context, state, cubit);
                            } else {
                              showSnackBar('A code has been sent to ${state.email}', context);
                              cubit.signupStepChanged(SignupSteps.verifyOtp);
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
                      if (state.step == SignupSteps.chooseType)
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Center(
                              child: Wrap(
                                children: const <Widget>[
                                  Text('By signing up, you agree to the'),
                                  Text(
                                    'Terms of Service ',
                                    style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                  ),
                                  Text('and '),
                                  Text(
                                    'Privacy Policy',
                                    style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (state.step == SignupSteps.chooseType)
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
                            if (state.step == SignupSteps.generateOtp) {
                              cubit.signupStepChanged(SignupSteps.chooseType);
                            } else if (state.step == SignupSteps.verifyOtp) {
                              cubit.signupStepChanged(SignupSteps.generateOtp);
                            }
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.clear,
                            color: PXColor.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PXSpacing.spacingXXL),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${state.signupType == SignupType.email ? 'Email' : 'Phone'} Verification',
                        style: const TextStyle(fontSize: PXFontSize.sizeXXL, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: PXSpacing.spacingL),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Please enter the 6-digit code sent to you at ${state.signupType == SignupType.email ? state.email : '${state.country.dialCode}${state.phone}'}',
                        style: const TextStyle(
                          color: PXColor.grey,
                          fontSize: PXFontSize.body,
                        ),
                      ),
                    ),
                    const SizedBox(height: PXSpacing.spacingXXL),
                    Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(children: <Widget>[
                          OtpTextField(onChangeField: (String value, int index) {
                            cubit.setOtpNumber(value, index);
                          }),
                          const SizedBox(height: PXSpacing.spacingL),
                          Center(
                            child: GestureDetector(
                              child: const Text(
                                'Resend Code',
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                              onTap: () async {
                                if (state.signupType == SignupType.email) {
                                  try {
                                    final String code = await context.read<SignupRepository>().getEmailCode(state.email);
                                    if (code.isNotEmpty) {
                                      cubit.setEmailCode(code);
                                    } else {
                                      showSnackBar('Email is already associated with other account', context);
                                    }
                                  } catch (e) {
                                    showSnackBar('Email is already associated with other account', context);
                                  }
                                } else {
                                  verifyPhoneNumber('${state.country.dialCode!}${state.phone}', context, state, cubit);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: PXSpacing.spacingXL),
                          if (state.signupType == SignupType.email)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text('We’ve sent you a new code. Don’t forget to check your junk folder!'),
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
                                    final bool isEmpty = state.otp.any((String element) => element.isEmpty);
                                    if (isEmpty) {
                                      return;
                                    }
                                    cubit.setLoading(true);
                                    if (state.signupType == SignupType.phone) {
                                      final String? id =
                                      await context.read<SignupRepository>().verifyPhoneOtp(state.otp.join(), state.verificationId);
                                      if (id == null) {
                                        showSnackBar('Invalid code', context);
                                      } else {
                                        cubit.setUserId(id);
                                        navigateToSelectNameScreen(context);
                                      }
                                      cubit.setLoading(false);
                                    } else {
                                      if (state.emailCode == state.otp.join()) {
                                        try {
                                          final UserCredential d =
                                          await _auth.createUserWithEmailAndPassword(email: state.email, password: 'STATIC_PWD');
                                          final String uid = d.user!.uid;
                                          cubit.setUserId(uid);
                                          cubit.setLoading(false);
                                          navigateToSelectNameScreen(context);
                                        } catch (e) {
                                          print("$e");
                                          if (e.toString().contains("firebase_auth/email-already-in-use")) {
                                            showSnackBar('Email is already associated with other account', context);
                                          }

                                          try {
                                            final UserCredential data =
                                            await _auth.signInWithEmailAndPassword(email: state.email, password: 'STATIC_PWD');
                                            final String uid = data.user!.uid;
                                            cubit.setUserId(uid);
                                            navigateToSelectNameScreen(context);
                                          } finally {
                                            cubit.setLoading(false);
                                          }
                                        }
                                      } else {
                                        cubit.setLoading(false);
                                        showSnackBar('Invalid code', context);
                                      }
                                    }
                                  },
                                  child: state.loading ? const CupertinoActivityIndicator(color: PXColor.white) : const Text('Submit')))
                        ]))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void codeSent(String verificationId, BuildContext ctx, phone) {
    showSnackBar('A code has been sent to $phone', ctx);
  }

  void codeAutoRetrievalTimeout(String verificationId, BuildContext ctx) {
    showSnackBar('verification code: $verificationId', ctx);
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context, SignupState state, SignupCubit cubit) async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(minutes: 2),
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            cubit.setLoading(false);
            cubit.setSmsCode(phoneAuthCredential.smsCode!);
            verificationCompleted(phoneAuthCredential, context);
          },
          verificationFailed: (FirebaseAuthException authException) {
            cubit.setLoading(false);
            verificationFailed(authException, context);
          },
          codeSent: (String code, int? i) {
            codeSent(code, context, '${state.country.dialCode} ${state.phone}');
            cubit.setVerificationId(code);
            cubit.signupStepChanged(SignupSteps.verifyOtp);
          },
          codeAutoRetrievalTimeout: (String id) {
            codeAutoRetrievalTimeout(id, context);
            cubit.setVerificationId(id);
          });
    } catch (e) {
      log("Failed to Verify Phone Number: $e");
      showSnackBar('Failed to Verify Phone Number: $e', context);
    }
  }

  Future<void> signInWithPhoneNumber(BuildContext ctx, String code, SignupState state, SignupCubit cubit) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId,
        smsCode: code,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      cubit.setUserId(user!.uid);
      navigateToSelectNameScreen(ctx);
    } catch (e) {
      showSnackBar('Failed to sign in: $e', ctx);
    } finally {
      cubit.setLoading(false);
    }
  }

  void showSnackBar(String message, BuildContext ctx) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, backgroundColor: PXColor.black, textColor: PXColor.white,toastLength: Toast.LENGTH_LONG);
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential, BuildContext ctx) {
    // await _auth.signInWithCredential(phoneAuthCredential);
    // showSnackbar(
    //     "Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}",
    //     ctx);
  }

  void verificationFailed(FirebaseAuthException authException, BuildContext ctx) {
    showSnackBar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}', ctx);
    log('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  }

  void navigateToSelectNameScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) => RepositoryProvider<SignupRepository>.value(
          value: context.read<SignupRepository>(),
          child: BlocProvider<SignupCubit>.value(
            value: BlocProvider.of<SignupCubit>(context),
            child: SelectNameScreen(),
          ),
        ),
      ),
    );
  }

  Future<void> _fabebookLogin(SignupCubit cubit) async {
    final FacebookLoginResult res = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        final String token = accessToken?.token ?? '';
        log('face book access token : $token');
        log('face book access token2: ${ await facebookLogin.accessToken}');

        final FacebookUserProfile? profile = await facebookLogin.getUserProfile();
        final String? userProfile = profile?.userId;
        final String? userName = profile?.name;

        final String? email = await facebookLogin.getUserEmail();
        if (email != null) final String userEmail = email;
        cubit.emailChanged(email!);
        cubit.setUserId(profile!.userId);
        final OAuthCredential credential =
        FacebookAuthProvider.credential(token);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: "STATIC_PWD").catchError((e) {
          if (e.toString().contains("firebase_auth/email-already-in-use")) {
            showFailureSnackBar('Email is already associated with other account');
          }
        });
        cubit.signupTypeChanged(SignupType.facebook);
        navigateToSelectNameScreen(context);
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        log('Error while log in: ${res.error}');
        break;
    }
  }
}

void _showPicker(BuildContext ctx, List<Country> countries, Country? country, Function(Country) onSave) {
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
              scrollController: FixedExtentScrollController(initialItem: index),
              children: <Widget>[
                for (Country item in countries)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(width: PXSpacing.spacingS),
                      _Flag(
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
              onSave(countries.elementAt(index));
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

class _Flag extends StatelessWidget {
  final Country? country;

  const _Flag({Key? key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null
        ? Image.asset(
      country!.flagUri,
      width: 32.0,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return const SizedBox.shrink();
      },
    )
        : const SizedBox.shrink();
  }
}

Widget _textFieldOTP({bool? first, bool? last, required BuildContext context, required Function(String) onChange}) {
  return SizedBox(
    height: 45,
    child: AspectRatio(
      aspectRatio: 1,
      child: CupertinoTextField(
        autofocus: true,
        onChanged: (String value) {
          onChange.call(value);
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), border: Border.all(color: PXColor.lightGrey)),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    ),
  );
}
