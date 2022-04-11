import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/utils/globals.dart' as globals;
// Services:
import 'package:packs/utils/services/authentication_manager.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:user_repository/user_repository.dart';

class ApplicationRegion extends StatefulWidget {
  final User user;
  ApplicationRegion({required this.user});

  @override
  _ApplicationRegionState createState() => _ApplicationRegionState();
}

class _ApplicationRegionState extends State<ApplicationRegion> {
  final AuthenticationManager _auth = AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    final regions = ['Australia', 'New Zealand', 'Asia', 'Europe'];
    var selectedRegion = regions.first;

    void signInAnonymously() async {
      _auth.signInAnonymously().then((_) => {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => HomeScreen()))
          });
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        middle: Text('2/3'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('I am traveling to:'),
              Text(selectedRegion),
              CupertinoButton.filled(
                child: Text('Continue'),
                onPressed: () {
                  widget.user.regionOfInterest = selectedRegion;

                  globals.currentUserData = widget.user;
                  signInAnonymously();
                },
              ),
              CupertinoPicker(
                backgroundColor: Colors.white,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedRegion = regions[index];
                  });
                },
                itemExtent: 260,
                children: [
                  for (final item in regions) Text(item),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
