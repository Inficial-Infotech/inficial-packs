import 'package:flutter/cupertino.dart';
import 'package:packs/widgets/components/segmented_control.dart';
// Widgets
import 'package:packs/widgets/components/tab_bar.dart';

const segmentedControlSegments = ['Details', 'About me', 'Requests'];

class MeetupsDetailScreen extends StatefulWidget {
  static const String id = "MeetupsDetailScreen";

  @override
  _MeetupsDetailScreen createState() => _MeetupsDetailScreen();
}

class _MeetupsDetailScreen extends State<MeetupsDetailScreen> {
  var segmentedControlValue = 0;

  void callback(int segmentedControlValue) {
    setState(() {
      this.segmentedControlValue = segmentedControlValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            SegmentedControl(
              items: segmentedControlSegments,
              segmentedControlValue: segmentedControlValue,
              callback: this.callback,
            ),
            Container(
              child: [
                for (final item in segmentedControlSegments)
                  Center(child: Text(item)),
              ][segmentedControlValue],
            ),
            Center(child: Text('MeetupsDetailScreen')),
            PXTabBar(activeRouteId: MeetupsDetailScreen.id),
          ],
        ),
      ),
    );
  }
}
