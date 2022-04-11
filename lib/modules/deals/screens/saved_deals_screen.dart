import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/utils/globals.dart' as globals;
// Widgets:
import 'package:packs/widgets/components/tab_bar.dart';
import 'package:packs/widgets/components/deals_list.dart';

class SavedScreen extends StatelessWidget {
  static const String id = "SavedScreen";

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
                    largeTitle: Text('Saved'),
                    automaticallyImplyLeading: false,
                  )
                ];
              },
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: DealsList(
                  queryDocIDs: globals.currentUserData.savedDeals,
                  scrollController: ScrollController(),
                ),
              ),
            ),
            PXTabBar(activeRouteId: SavedScreen.id),
          ],
        ),
      ),
    );
  }
}
