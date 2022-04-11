import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/login/cubit/login_cubit.dart';

// Widgets:
import 'package:packs/core/login/login_screen.dart';
import 'package:packs/core/repositories/login_repository.dart';
import 'package:packs/core/repositories/signup_repository.dart';
import 'package:packs/core/signup/cubit/signup_cubit.dart';
import 'package:packs/core/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = "WelcomeScreen";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/stage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                    SizedBox(height: PXSpacing.spacingXL),
                    Center(
                      child: Text(
                        'Exploring made simple',
                        style: TextStyle(fontSize: 15, color: PXColor.white),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(30.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (BuildContext ctx) => RepositoryProvider(
                              create: (BuildContext context) =>
                                  SignupRepository(
                                context.read<AuthenticationRepository>(),
                              ),
                              child: BlocProvider(
                                create: (BuildContext context) =>
                                    SignupCubit()..loadCountries('AU'),
                                child: const SignupScreen(),
                              ),
                            ),
                          ));
                    },
                    child: const Text('Signup'),
                  ),
                  const SizedBox(height: PXSpacing.spacingM),
                  CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(30.0),
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (BuildContext ctx) => RepositoryProvider(
                              create: (BuildContext context) => LoginRepository(
                                context.read<AuthenticationRepository>(),
                              ),
                              child: BlocProvider(
                                create: (BuildContext context) => LoginCubit(
                                  context.read<AuthenticationRepository>(),
                                )..loadCountries('AU'),
                                child: const LoginScreen(),
                              ),
                            ),
                          ));
                    },
                  ),
                  const SizedBox(height: PXSpacing.spacingXL),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
