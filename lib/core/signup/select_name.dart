import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/repositories/signup_repository.dart';
import 'package:packs/core/signup/cubit/signup_cubit.dart';
import 'package:packs/core/signup/select_country.dart';
import 'package:packs/widgets/components/back_button.dart';

class SelectNameScreen extends StatelessWidget {
  static const String id = 'SelectNameScreen';

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SignupCubit _signupCubit = BlocProvider.of<SignupCubit>(context);
    return CupertinoPageScaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      child: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: PXSpacing.spacingL, right: PXSpacing.spacingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_signupCubit.state.email),
              SizedBox(height: PXSpacing.spacingXXL),
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
                      },
                      child: Icon(CupertinoIcons.clear,
                          color: PXColor.black, size: 30)),
                ],
              ),
              SizedBox(height: PXSpacing.spacingXXL),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Whats your name?',
                    style: TextStyle(
                        fontSize: PXFontSize.sizeXXL,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: PXSpacing.spacingXXL),
              Row(
                children: [
                  Icon(CupertinoIcons.smiley, color: PXColor.black),
                  SizedBox(width: PXSpacing.spacingS),
                  Expanded(
                    child: CupertinoTextField(
                      autofocus: true,
                      placeholder: "First name",
                      decoration: BoxDecoration(
                        color: PXColor.transparent,
                      ),
                      onChanged: (String value) {
                        _signupCubit.nameChanged(value);
                      },
                    ),
                  ),
                ],
              ),
              Divider(height: PXSpacing.spacingXXS),
              SizedBox(height: PXSpacing.spacingXXL),
              CupertinoButton.filled(
                  child: Text('Continue'),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  onPressed: () {
                    if (BlocProvider.of<SignupCubit>(context)
                        .state
                        .name
                        .isEmpty) {
                      return;
                    }
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (ctx) => RepositoryProvider.value(
                                value: context.read<SignupRepository>(),
                                child: BlocProvider.value(
                                  value: BlocProvider.of<SignupCubit>(context),
                                  child: SelectCountryScreen(),
                                ),
                              )),
                    );
                  })
            ],
          ),
        ),
      )),
    );
  }
}
