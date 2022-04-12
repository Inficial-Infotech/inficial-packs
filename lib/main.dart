import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/bloc/root_bloc.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/config/routes/routes.dart';
import 'package:packs/core/login/login_screen.dart';
import 'package:packs/utils/globals.dart' as globals;

import 'package:authentication_repository/authentication_repository.dart';
// Services:
import 'package:packs/utils/services/database_manager.dart';
import 'package:packs/utils/services/authentication_manager.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
// Widgets:
import 'package:packs/widgets/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  // if (authenticationRepository.user != null) {
  //   await authenticationRepository.user.first;
  // }
  runApp(PACKS(authenticationRepository: authenticationRepository));
}

class PACKS extends StatelessWidget {
  const PACKS({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            RootBloc(authenticationRepository: _authenticationRepository)
              ..add(RootUserFetch()),
        child: CupertinoApp(
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          title: 'PACKS',
          home: Root(
              authenticationRepository: _authenticationRepository, key: key),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<Root> {
  // final AuthenticationManager _auth = AuthenticationManager();
  final DatabaseManager _database = DatabaseManager();

  UserAuthStatus authStatus = UserAuthStatus.pending;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(builder: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.unknown:
          return LoadingScreen();
        case AuthenticationStatus.authenticated:
          return HomeScreen();
        case AuthenticationStatus.unauthenticated:
          return WelcomeScreen();
      }
    });
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text('Loading..'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
