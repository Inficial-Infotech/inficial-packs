import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/screens/meetup_add_date_time_screen.dart';

class MeetupsAddTitleAndDesScreen extends StatefulWidget {
  const MeetupsAddTitleAndDesScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupsAddTitleAndDesScreen';

  @override
  _MeetupsAddMeetupScreen createState() => _MeetupsAddMeetupScreen();
}

class _MeetupsAddMeetupScreen extends State<MeetupsAddTitleAndDesScreen> {
  late MeetUpCubit meetUpCubit;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                child: Text('Create Meet Up Title and Description Screen'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: titleController,
                  placeholder: 'Title',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: descriptionController,
                  placeholder: 'Amet minim mollit mon....',
                  maxLines: 5,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    return;
                  }
                  meetUpCubit.titleAndDes(
                      titleController.text, descriptionController.text);
                  navigateToMeetUpTitleAndDescriptionScreen(context);
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToMeetUpTitleAndDescriptionScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) => BlocProvider<MeetUpCubit>.value(
          value: BlocProvider.of<MeetUpCubit>(context),
          child: const MeetupAddDateTimeScreen(),
        ),
      ),
    );
  }
}
