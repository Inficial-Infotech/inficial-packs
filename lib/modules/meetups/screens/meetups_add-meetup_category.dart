import 'package:flutter/cupertino.dart';
import 'package:packs/widgets/components/icon_button.dart';

class MeetupsAddMeetupScreen extends StatefulWidget {
  static const String id = "AddMeetupScreen";

  @override
  _MeetupsAddMeetupScreen createState() => _MeetupsAddMeetupScreen();
}

class _MeetupsAddMeetupScreen extends State<MeetupsAddMeetupScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: PXIconButton(
            icon: CupertinoIcons.xmark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
