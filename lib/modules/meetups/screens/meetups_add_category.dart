import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/screens/meetups_add_title_des_screen.dart';

class MeetupsAddCategoryScreen extends StatefulWidget {
  const MeetupsAddCategoryScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupsAddMeetupScreen';

  @override
  _MeetupsAddMeetupScreen createState() => _MeetupsAddMeetupScreen();
}

class _MeetupsAddMeetupScreen extends State<MeetupsAddCategoryScreen> {
  List<String> categoryList = const <String>['Day activity', 'Night out', 'Multi-day', 'Mini getaway'];

  String selectedValue = '';
  late MeetUpCubit meetUpCubit;

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
                child: Text('Create Meet Up Category Screen'),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () async {
                  selectedValue = await showCategoryPicker();
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(selectedValue.isEmpty ? 'Category' : selectedValue),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  if (selectedValue.isEmpty) {
                    return;
                  }
                  meetUpCubit.setCategory(selectedValue);
                  navigateToMeetUpTitleAndDesScreen(context);
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> showCategoryPicker() async {
    String selectCategory = '';
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.black,
          child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              selectCategory = categoryList[value];
            },
            itemExtent: 25,
            diameterRatio: 1,
            useMagnifier: true,
            magnification: 1.3,
            children: List<Widget>.generate(categoryList.length, (int index) => Text(categoryList[index])).toList(),
          ),
        );
      },
    );
    return selectCategory;
  }

  void navigateToMeetUpTitleAndDesScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) => BlocProvider<MeetUpCubit>.value(
          value: BlocProvider.of<MeetUpCubit>(context),
          child: const MeetupsAddTitleAndDesScreen(),
        ),
      ),
    );
  }
}
