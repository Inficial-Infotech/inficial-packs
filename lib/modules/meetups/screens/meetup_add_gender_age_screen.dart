import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/repository/meetup_repository.dart';
import 'package:packs/modules/meetups/screens/meetup_add_cover_image_screen.dart';

class MeetupAddGenderAgeScreen extends StatefulWidget {
  const MeetupAddGenderAgeScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupAddGenderAgeScreen';

  @override
  _MeetupAddGenderAgeScreenState createState() => _MeetupAddGenderAgeScreenState();
}

class _MeetupAddGenderAgeScreenState extends State<MeetupAddGenderAgeScreen> {
  late MeetUpCubit meetUpCubit;
  List<String> genderList = const <String>['Male', 'Female', 'Other'];

  String selectedValue = '';
  final TextEditingController startAgeController = TextEditingController();
  final TextEditingController endAgeController = TextEditingController();
  final TextEditingController noOfPeopleController = TextEditingController();

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
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Create Meet Up Gender and Age Screen'),
              ),
              GestureDetector(
                onTap: () {
                  showGenderPicker();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(selectedValue.isEmpty ? 'Gender' : selectedValue),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Start Age And End Age'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: CupertinoTextField(
                    keyboardType: TextInputType.number,
                    controller: startAgeController,
                    placeholder: 'Start Age',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: CupertinoTextField(
                    controller: endAgeController,
                    keyboardType: TextInputType.number,
                    placeholder: 'End Age',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: noOfPeopleController,
                  keyboardType: TextInputType.number,
                  placeholder: 'No Of People',
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CupertinoButton.filled(

                onPressed: () {
                  if (selectedValue.isEmpty ||
                      startAgeController.text.isEmpty ||
                      endAgeController.text.isEmpty ||
                      noOfPeopleController.text.isEmpty) {
                    return;
                  }
                  meetUpCubit.setGenderAndAeg(
                    selectedValue,
                    int.parse(startAgeController.text),
                    int.parse(endAgeController.text),
                    int.parse(noOfPeopleController.text),
                  );
                  navigateToMeetupAddCoverImageScreen(context);
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showGenderPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              selectedValue = genderList[value];
              setState(() {});
            },
            itemExtent: 25,
            diameterRatio: 1,
            useMagnifier: true,
            magnification: 1.3,
            children: List<Widget>.generate(genderList.length, (int index) => Text(genderList[index])).toList(),
          ),
        );
      },
    );
  }

  void navigateToMeetupAddCoverImageScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) => RepositoryProvider<MeetupRepository>(
          create: (BuildContext context) => MeetupRepository(),
          child: BlocProvider<MeetUpCubit>.value(
            value: BlocProvider.of<MeetUpCubit>(context),
            child: const MeetupAddCoverImageScreen(),
          ),
        ),
      ),
    );
  }
}
