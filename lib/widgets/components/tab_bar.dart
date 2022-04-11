import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/core/profile/profile_screen.dart';
import 'package:packs/modules/home/screens/bookings/screens/bookings_screen.dart';
// Widgets:
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:packs/modules/meetups/screens/meetups_overview_screen.dart';

class NavItemModel {
  String id;
  String name;
  IconData iconActive;
  IconData iconInactive;

  NavItemModel({
    required this.id,
    required this.name,
    required this.iconActive,
    required this.iconInactive,
  });
}

class PXTabBar extends StatelessWidget {
  final String activeRouteId;

  PXTabBar({required this.activeRouteId});

  final List<NavItemModel> navItems = [
    NavItemModel(
      id: HomeScreen.id,
      name: 'Home',
      iconActive: CupertinoIcons.house_fill,
      iconInactive: CupertinoIcons.house,
    ),
    NavItemModel(
      id: MeetupsOverviewScreen.id,
      name: 'Meetups',
      iconActive: CupertinoIcons.person_2_fill,
      iconInactive: CupertinoIcons.person_2,
    ),
    NavItemModel(
      id: BookingsScreen.id,
      name: 'Bookings',
      iconActive: CupertinoIcons.ticket_fill,
      iconInactive: CupertinoIcons.ticket,
    ),
    NavItemModel(
      id: ProfileScreen.id,
      name: 'Profile',
      // TODO: Will be replaced by actual profile image later
      iconActive: CupertinoIcons.person_circle_fill,
      iconInactive: CupertinoIcons.person_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60.0,
      child: Center(
        child: Container(
          width: 310,
          height: 72,
          decoration: BoxDecoration(
            color: PXColor.black,
            borderRadius: BorderRadius.circular(PXBorderRadius.radiusL),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (NavItemModel item in navItems)
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Icon(
                              activeRouteId == item.id
                                  ? item.iconActive
                                  : item.iconInactive,
                              color: PXColor.white,
                            ),
                            const SizedBox(height: PXSpacing.spacingXS),
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: PXFontSize.sizeXS,
                                height: PXLineHeight.heightM,
                                fontWeight: activeRouteId == item.id
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: PXColor.white,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          if (activeRouteId != item.id) {
                            final routeName =
                                item.id.toString().split('.').last;
                            Navigator.of(context).pushNamed(routeName);
                          }
                        },
                      ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
