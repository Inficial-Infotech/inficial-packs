import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
// Services:
import 'package:packs/utils/services/authentication_manager.dart';
import 'package:packs/utils/services/database_manager.dart';
// Widgets:
import 'package:packs/core/registration/registration_screen.dart';
import 'package:packs/widgets/screens/welcome_screen.dart';
import 'package:packs/widgets/components/tab_bar.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "ProfileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationManager _auth = AuthenticationManager();
  final DatabaseManager _database = DatabaseManager();

  bool showSpinner = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  CupertinoSliverNavigationBar(
                    backgroundColor: PXColor.white,
                    border: Border(),
                    largeTitle: Text('My Account'),
                    automaticallyImplyLeading: false,
                  )
                ];
              },
              body: Column(
                children: [
                  SizedBox(
                    height: 48.0,
                  ),
                  CupertinoButton.filled(
                    child: Text('Add Dummy Deal'),
                    onPressed: () async {
                      _database.setDummyDeeal();
                    },
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  CupertinoButton.filled(
                    child: Text('Complete Registration'),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                  ),
                  CupertinoButton(
                    child: Text('Sign Out'),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
            PXTabBar(activeRouteId: ProfileScreen.id),
          ],
        ),
      ),
    );
  }
}
