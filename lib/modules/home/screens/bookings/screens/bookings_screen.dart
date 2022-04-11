import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/utils/globals.dart' as globals;
// Widgets:
import 'package:packs/widgets/components/tab_bar.dart';
import 'package:packs/widgets/components/deals_list.dart';

class BookingsScreen extends StatelessWidget {
  static const String id = "BookingsScreen";

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
                    largeTitle: Text('Bookings'),
                    automaticallyImplyLeading: false,
                  )
                ];
              },
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Center(
                  child: Text('Bookings'),
                ),
              ),
            ),
            PXTabBar(activeRouteId: BookingsScreen.id),
          ],
        ),
      ),
    );
  }
}
