part of 'meetup_cubit.dart';

class MeetUpState extends Equatable {
  MeetUpState({
    this.category = '',
    this.title = '',
    this.description = '',
    this.startDate = '',
    this.startTime = '',
    this.endDate = '',
    this.endTime = '',
    this.gender = '',
    this.imageURLs = const [],
    this.coverImageURL = '',
    this.minAge = 0,
    this.maxAge = 0,
    this.maxNumberOfParticipants = 0,
    this.lng = 0.0,
    this.address = '',
    this.lat = 0.0
  });

  String category;
  String title;
  String description;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String gender;
  String coverImageURL;
  String address;
  double lat;
  double lng;
  List<String> imageURLs;
  int minAge;
  int maxAge;
  int maxNumberOfParticipants;

  @override
  List<Object> get props => [
        category,
        description,
        title,
        startDate,
        startTime,
        endDate,
        endTime,
        gender,
        minAge,
        maxAge,
        imageURLs,
        maxNumberOfParticipants,
        coverImageURL,
        address,
        lat,
        lng,
      ];

  MeetUpState copyWith({
    String? category,
    String? description,
    String? title,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    String? gender,
    String? coverImageURL,
    String? address,
    double? lat,
    double? lng,
    List<String>? imageURLs,
    int? minAge,
    int? maxAge,
    int? maxNumberOfParticipants,
  }) {
    return MeetUpState(
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      minAge: minAge ?? this.minAge,
      gender: gender ?? this.gender,
      maxAge: maxAge ?? this.maxAge,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      maxNumberOfParticipants: maxNumberOfParticipants ?? this.maxNumberOfParticipants,
      coverImageURL: coverImageURL ?? this.coverImageURL,
      imageURLs: imageURLs ?? this.imageURLs,
    );
  }
}
