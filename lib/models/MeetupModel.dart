import 'AddressModel.dart';
import 'UserModel.dart';

class MeetupModel {
  String title;
  UserModel owner;
  AddressModel? address;
  List<UserModel> participants;
  List<UserModel> openRequests;
  String startDate;
  String endDate;

  MeetupModel({
    required this.title,
    required this.owner,
    required this.address,
    required this.participants,
    required this.openRequests,
    required this.startDate,
    required this.endDate,
  });
}
