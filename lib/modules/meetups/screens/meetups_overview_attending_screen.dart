import 'package:flutter/cupertino.dart';
import 'package:packs/widgets/components/meetup_card.dart';
import 'package:packs/widgets/components/range_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

// TODO: Remove when dummy meetup card model is replaced by actual data
import '../../../models/AddressModel.dart';
import '../../../models/MeetupModel.dart';
import '../../../models/UserModel.dart';
import '../../../widgets/components/meetup_card.dart';

class MeetupsOverviewAttendingScreen extends StatefulWidget {
  const MeetupsOverviewAttendingScreen({Key? key}) : super(key: key);

  @override
  State<MeetupsOverviewAttendingScreen> createState() =>
      _MeetupsOverviewAttendingScreenState();
}

class _MeetupsOverviewAttendingScreenState
    extends State<MeetupsOverviewAttendingScreen> {
  SfRangeValues _values = const SfRangeValues(30.0, 80.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PXRangeSlider(
          title: 'Price range',
          icon: CupertinoIcons.money_dollar,
          min: 0,
          max: 100,
          values: _values,
          onChanged: (SfRangeValues values) {
            setState(() {
              _values = values;
            });
          },
        ),

        // TODO: Replace dummy Data
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
