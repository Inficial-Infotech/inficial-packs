import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:packs/api/rest_api_service.dart';

class MeetupRepository {
  Future<String> publishMeetup({
    required String userId,
    required String category,
    required String title,
    required String description,
    required String startDate,
    required String startTime,
    required String endDate,
    required String endTime,
    required String gender,
    required int minAge,
    required int maxAge,
    required int maxNumberOfParticipants,
    required String coverImageURL,
    required List<String> imageURLs,
  }) async {
    try {
      final Map<String, dynamic> jsonString = {
        'UserID': userId,
        'category': category,
        'title': title,
        'description': description,
        'startDate': startDate,
        'startTime': startTime,
        'endDate': endDate,
        'endTime': endTime,
        'gender': gender,
        'ageStartValue': minAge,
        'ageEndValue': maxAge,
        'noOfPeople': maxNumberOfParticipants,
        'coverImageURL': coverImageURL,
        'ImagesURL': imageURLs,
      };

      final Response result = await RestApiService().post('mobile-app/publish-meetups', jsonString);

      log('result : ${result.body}');
      if (result.statusCode == 200) {
        return json.decode(result.body)['data']['result'].toString();
      }
    } catch (e, st) {
      rethrow;
    }
    return '';
  }

  Future<void> uploadImageFirebase(List<Map<String, dynamic>> uploadImageDataList) async {
    await FirebaseFirestore.instance
        .collection('MEETUP_IMAGE')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({'images': FieldValue.arrayUnion(uploadImageDataList)}, SetOptions(merge: true));
  }
}
