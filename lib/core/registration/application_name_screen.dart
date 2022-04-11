import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
// Widgets:
import 'package:packs/core/registration/application_region_screen.dart';
import 'package:user_repository/user_repository.dart';

class ApplicationName extends StatelessWidget {
  final User user;
  ApplicationName({required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController _applicationInputController = TextEditingController();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        middle: Text('1/3'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('What‘s your name?'),
              CupertinoTextField(
                controller: _applicationInputController,
                autofocus: true,
              ),
              Text(
                'This information will be public',
                style: PXTextStyle.styleSRegular,
              ),
              CupertinoButton.filled(
                child: Text('Continue'),
                onPressed: () {
                  user.firstName = _applicationInputController.text.trim();
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ApplicationRegion(user: user)),
                  );
                },
              )
              // PXButton(
              //   title: 'Continue',
              //   onPressed: () {
              //     user.firstName = _applicationInputController.text.trim();
              //     Navigator.push(
              //       context,
              //       CupertinoPageRoute(
              //           builder: (context) => ApplicationRegion(user: user)),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
