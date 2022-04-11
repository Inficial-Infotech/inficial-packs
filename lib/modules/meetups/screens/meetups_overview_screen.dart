import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/AddressModel.dart';
import 'package:packs/models/MeetupModel.dart';
import 'package:packs/models/UserModel.dart';
import 'package:packs/modules/meetups/screens/meetups_add-meetup_category.dart';
import 'package:packs/widgets/components/bar_button.dart';
import 'package:packs/widgets/components/header.dart';
import 'package:packs/widgets/components/meetup_card.dart';
import 'package:packs/widgets/components/segmented_control.dart';
import 'package:packs/widgets/components/tab_bar.dart';

const List<String> segmentedControlSegments = [
  'Attending',
  'My Meetups',
  'Requests',
];

class MeetupsOverviewScreen extends StatefulWidget {
  const MeetupsOverviewScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupsOverviewScreen';

  @override
  _MeetupsOverviewScreen createState() => _MeetupsOverviewScreen();
}

class _MeetupsOverviewScreen extends State<MeetupsOverviewScreen> {
  int segmentedControlValue = 0;

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
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: PXSliverPersistentHeaderDelegate(
                    openHeight: 118,
                    closedHeight: 40,
                    title: 'Meetups',
                    child: SegmentedControl(
                      items: segmentedControlSegments,
                      segmentedControlValue: segmentedControlValue,
                      callback: callback,
                    ),
                    hasBackButton: true,
                    barButtons: [
                      PXBarButton(
                        icon: CupertinoIcons.plus,
                        onTap: () => {
                          Navigator.of(context)
                              .pushNamed(MeetupsAddMeetupScreen.id),
                        },
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: [
                          MeetupsDetailScreenAttending(),
                          MeetupsDetailScreenMyMeetups(),
                          MeetupsDetailScreenRequests(),
                        ][segmentedControlValue],
                      ),
                      const SizedBox(height: PXSpacing.spacingS),
                    ],
                  ),
                ),
              ],
            ),
            PXTabBar(activeRouteId: MeetupsOverviewScreen.id),
          ],
        ),
      ),
    );
  }
}

class MeetupsDetailScreenAttending extends StatelessWidget {
  const MeetupsDetailScreenAttending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MeetupCard(
          model: MeetupModel(
            title: 'Sunset picnic at Bondi beach',
            owner: UserModel(
              firstName: 'Yule',
              logoURL:
                  'https://media.istockphoto.com/photos/close-up-portrait-of-brunette-woman-picture-id1154642632?k=20&m=1154642632&s=612x612&w=0&h=dQPjQCt_WOKhD0ysSJG6gIsu7xW65vH8Wf_SaqetIqY=',
            ),
            address: AddressModel(
              city: 'Sydney',
              country: 'Australia',
            ),
            startDate: '11.06.2022',
            endDate: '12.06.2022',
            participants: [
              UserModel(
                uid: '',
                firstName: 'Nishit',
                logoURL:
                    'https://media.istockphoto.com/photos/close-up-portrait-of-brunette-woman-picture-id1154642632?k=20&m=1154642632&s=612x612&w=0&h=dQPjQCt_WOKhD0ysSJG6gIsu7xW65vH8Wf_SaqetIqY=',
              ),
            ],
            openRequests: [],
          ),
        ),
      ],
    );
  }
}

class MeetupsDetailScreenMyMeetups extends StatelessWidget {
  const MeetupsDetailScreenMyMeetups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MeetupsDetailScreenRequests extends StatelessWidget {
  const MeetupsDetailScreenRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
