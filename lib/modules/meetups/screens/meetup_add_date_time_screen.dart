import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/repository/meetup_repository.dart';
import 'package:packs/modules/meetups/screens/meetup_add_area_screen.dart';

class MeetupAddDateTimeScreen extends StatefulWidget {
  const MeetupAddDateTimeScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupAddDateTimeScreen';

  @override
  _MeetupAddDateTimeScreenState createState() =>
      _MeetupAddDateTimeScreenState();
}

class _MeetupAddDateTimeScreenState extends State<MeetupAddDateTimeScreen> {
  late MeetUpCubit meetUpCubit;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

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
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Create Meet Up Date and Duration Screen'),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Start Date Time'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () async {
                    startDateController.text = await datePicker(context);
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: CupertinoTextField(
                      enabled: false,
                      controller: startDateController,
                      placeholder: 'DD/MM/YY',
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  startTimeController.text = await timePicker(context);
                  setState(() {});
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: CupertinoTextField(
                    enabled: false,
                    controller: startTimeController,
                    placeholder: '9AM',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('End Date Time'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  endDateController.text = await datePicker(context);
                  setState(() {});
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: CupertinoTextField(
                    enabled: false,
                    controller: endDateController,
                    placeholder: 'DD/MM/YY',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  endTimeController.text = await timePicker(context);
                  setState(() {});
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: CupertinoTextField(
                    enabled: false,
                    controller: endTimeController,
                    placeholder: '9AM',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Align(
              child: CupertinoButton.filled(
                onPressed: () {
                  if (startDateController.text.isEmpty ||
                      startTimeController.text.isEmpty ||
                      endDateController.text.isEmpty ||
                      endTimeController.text.isEmpty) {
                    return;
                  }
                  meetUpCubit.setDateAndTime(
                    startDateController.text,
                    startTimeController.text,
                    endDateController.text,
                    endTimeController.text,
                  );
                  showCupertinoModalBottomSheet(
                    context: context,
                    topRadius: const Radius.circular(25),
                    barrierColor: Colors.black,
                    builder: (BuildContext ct) =>
                        RepositoryProvider<MeetupRepository>(
                      create: (BuildContext context) => MeetupRepository(),
                      child: BlocProvider<MeetUpCubit>.value(
                        value: BlocProvider.of<MeetUpCubit>(context),
                        child: const MeetupAddAreaScreen(),
                      ),
                    ),
                  );
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> datePicker(BuildContext context) async {
    String selectDate = '';
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 280,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: DateTime.now().year + 2,
          backgroundColor: PXColor.white,
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime dateTime) {
            selectDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
          },
        ),
      ),
    );
    return selectDate;
  }

  Future<String> timePicker(BuildContext context) async {
    String selectTime = '';
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 280,
        child: CupertinoDatePicker(
          backgroundColor: PXColor.white,
          mode: CupertinoDatePickerMode.time,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime dateTime) {
            selectTime = DateFormat('hh:mm a').format(dateTime);
          },
        ),
      ),
    );
    return selectTime;
  }
}
