import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/modules/home/screens/home_screen.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/repository/meetup_repository.dart';
import 'package:packs/utils/globals.dart' as globals;

class MeetupAddAgreementScreen extends StatefulWidget {
  const MeetupAddAgreementScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupAddAgreementScreen';

  @override
  _MeetupAddAgreementScreenState createState() => _MeetupAddAgreementScreenState();
}

class _MeetupAddAgreementScreenState extends State<MeetupAddAgreementScreen> {
  bool checkedValue = false;
  late MeetUpCubit meetUpCubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    meetUpCubit = BlocProvider.of<MeetUpCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Align(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Create Meet Up Agreement Screen'),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CupertinoSwitch(
                    value: checkedValue,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                      child: Text(
                    'I promise to respect nature and always clean up after may self',
                    maxLines: 5,
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Align(
              child: CupertinoButton.filled(
                onPressed: () async {
                  if (checkedValue) {
                    try {
                      isLoading = true;
                      setState(() {});
                      await context.read<MeetupRepository>().publishMeetup(
                            userId: globals.currentUserData.uid ?? '',
                            category: meetUpCubit.state.category,
                            title: meetUpCubit.state.title,
                            description: meetUpCubit.state.description,
                            startDate: meetUpCubit.state.startDate,
                            startTime: meetUpCubit.state.startTime,
                            endDate: meetUpCubit.state.endDate,
                            endTime: meetUpCubit.state.endTime,
                            gender: meetUpCubit.state.gender,
                            minAge: meetUpCubit.state.minAge,
                            maxAge: meetUpCubit.state.maxAge,
                            maxNumberOfParticipants: meetUpCubit.state.maxNumberOfParticipants,
                            coverImageURL: meetUpCubit.state.coverImageURL,
                            imageURLs: meetUpCubit.state.imageURLs,
                          );

                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext ctx) => HomeScreen(),
                        ),
                        ModalRoute.withName('/'),
                      );
                    } catch (e) {
                      print("Error: $e");
                      Fluttertoast.showToast(
                          msg: 'Something was wrong', gravity: ToastGravity.BOTTOM, backgroundColor: PXColor.black, textColor: PXColor.white);
                    }
                  }
                },
                child: isLoading ? const CupertinoActivityIndicator(color: PXColor.white) : const Text('Publish meetup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
