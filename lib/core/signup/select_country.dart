import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/repositories/signup_repository.dart';
import 'package:packs/core/signup/cubit/signup_cubit.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:packs/widgets/components/back_button.dart';
import 'package:packs/widgets/components/cupertino_list_tile/list_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectCountryScreen extends StatefulWidget {
  static const String id = 'SelectCountryScreen';

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
  }

  bool isOpenPicker = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

 int getProviderBySignUpType(SignupType signupType) {
    switch (signupType){
      case SignupType.phone : { return 1; }
      case SignupType.email : { return 1; }
      case SignupType.google : { return 2; }
      case SignupType.facebook : { return 3; }
    }
  }


  @override
  Widget build(BuildContext context) {
    SignupCubit _signupCubit = BlocProvider.of<SignupCubit>(context);
    return CupertinoPageScaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      child: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: PXSpacing.spacingL, right: PXSpacing.spacingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: PXSpacing.spacingXXS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PXBackButton(
                      colour: PXColor.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Icon(CupertinoIcons.clear,
                          color: PXColor.black, size: 30),
                    ),
                  ],
                ),
                SizedBox(height: PXSpacing.spacingXXL),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('What country are you exploring?',
                      style: TextStyle(
                        fontSize: PXFontSize.sizeXXL,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: PXSpacing.spacingXXL),
                Image.asset('assets/images/surf.png'),
                SizedBox(height: PXSpacing.spacingXXL),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpenPicker = !isOpenPicker;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: PXColor.athensGrey,
                        borderRadius: isOpenPicker
                            ? BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))
                            : BorderRadius.all(Radius.circular(10))),
                    child: CupertinoListTile(
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                      dense: true,
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                _signupCubit.state.countryExploring.flagUri),
                          ),
                        ),
                      ),
                      title: Text(
                        _signupCubit.state.countryExploring.name!,
                        style: TextStyle(fontSize: PXFontSize.body),
                      ),
                      showSeparator: false,
                      trailing: Icon(
                        isOpenPicker
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        color: PXColor.black,
                      ),
                    ),
                  ),
                ),
                isOpenPicker
                    ? Container(
                        decoration: BoxDecoration(color: PXColor.athensGrey),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            height: 1,
                            color: PXColor.grey,
                          ),
                        ),
                      )
                    : Container(),
                isOpenPicker
                    ? Container(
                        height: 260,
                        padding: EdgeInsets.symmetric(
                            horizontal: PXSpacing.spacingL),
                        decoration: BoxDecoration(
                            color: PXColor.athensGrey,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: ScrollablePositionedList.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _signupCubit.state.countries.length,
                          initialAlignment: 0.5,
                          initialScrollIndex: _signupCubit.state.countries
                              .indexOf(_signupCubit.state.countryExploring),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: GestureDetector(
                              onTap: () {
                                _signupCubit.exploringCountryChanged(
                                    _signupCubit.state.countries[index]);
                                setState(() {
                                  isOpenPicker = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: PXColor.athensGrey,
                                    borderRadius: isOpenPicker
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))
                                        : BorderRadius.all(
                                            Radius.circular(10))),
                                child: CupertinoListTile(
                                  contentPadding:
                                      EdgeInsets.only(top: 0, bottom: 0),
                                  dense: true,
                                  leading: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(_signupCubit
                                            .state.countries[index].flagUri),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _signupCubit.state.countries[index].name!,
                                    style: TextStyle(fontSize: PXFontSize.body),
                                  ),
                                  showSeparator: false,
                                  trailing: _signupCubit
                                              .state.countries[index].name ==
                                          _signupCubit
                                              .state.countryExploring.name
                                      ? Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: PXColor.black,
                                        )
                                      : SizedBox(width: 0, child: Container()),
                                ),
                              ),
                            ),
                          ),
                          itemScrollController: itemScrollController,
                        ),
                      )
                    : Container(),
                SizedBox(height: PXSpacing.spacingXL),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                      'Personalise your experience with PACKS! Don\'t worry, you can always change this later.'),
                ),
                SizedBox(height: PXSpacing.spacingXXL),
                CupertinoButton.filled(
                    child: loading
                        ? CupertinoActivityIndicator(
                            animating: true,
                            color: PXColor.black,
                          )
                        : Text('Done'),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    onPressed: loading
                        ? null
                        : () async {
                            setState(() {
                              loading = true;
                            });

                            try {
                              final bool result = await context
                                  .read<SignupRepository>()
                                  .signup(
                                    _signupCubit.state.signupType ==
                                                SignupType.email ||
                                            _signupCubit.state.signupType ==
                                                SignupType.google
                                        ? _signupCubit.state.email
                                        : '',
                                    _signupCubit.state.name,
                                    _signupCubit.state.signupType ==
                                            SignupType.phone
                                        ? '${_signupCubit.state.country.dialCode}${_signupCubit.state.phone}'
                                        : '',
                                    _signupCubit.state.userId,
                                    _signupCubit.state.countryExploring.name!,
                                    _signupCubit.state.signupType ==
                                        SignupType.phone,
                                    _signupCubit.state.smsCode,
                                    _signupCubit.state.verificationId,
                                    _signupCubit.state.emailCode,
                                  getProviderBySignUpType(_signupCubit.state.signupType)
                                  );

                              if (result) {
                                Fluttertoast.showToast(
                                    msg: 'Signup success',
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: PXColor.black,
                                    textColor: PXColor.white);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'Something went wrong, Please try again!',
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: PXColor.red,
                                    textColor: PXColor.white);
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Something went wrong, Please try again!',
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: PXColor.red,
                                  textColor: PXColor.white);
                            } finally {
                              setState(() {
                                loading = false;
                              });
                            }
                          })
              ],
            ),
          ),
        )),
      ),
    );
  }
}
