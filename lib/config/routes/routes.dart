import 'package:flutter/cupertino.dart';
import 'package:packs/core/profile/profile_screen.dart';

// Widgets:
// import 'package:packs/widgets/screens/HomeScreen.dart';
import 'package:packs/modules/deals/screens/saved_deals_screen.dart';
import 'package:packs/modules/home/screens/bookings/screens/bookings_screen.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:packs/modules/meetups/screens/meetups_add-meetup_category.dart';
import 'package:packs/modules/meetups/screens/meetups_detail_screen.dart';
import 'package:packs/modules/meetups/screens/meetups_overview_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.id:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case MeetupsOverviewScreen.id:
        return CupertinoPageRoute(builder: (_) => MeetupsOverviewScreen());
      case MeetupsDetailScreen.id:
        return CupertinoPageRoute(builder: (_) => MeetupsDetailScreen());
      case MeetupsAddMeetupScreen.id:
        return CupertinoPageRoute(
            builder: (_) => MeetupsAddMeetupScreen(), fullscreenDialog: true);
      case BookingsScreen.id:
        return CupertinoPageRoute(builder: (_) => BookingsScreen());
      case ProfileScreen.id:
        return CupertinoPageRoute(builder: (_) => ProfileScreen());
      case SavedScreen.id:
        return CupertinoPageRoute(builder: (_) => SavedScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return CupertinoPageScaffold(
        child: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
