import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    required String address,
    required double lat,
    required double lng,
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
        'address': address,
        'lat': lat,
        'lng': lng,
      };

      final Response result =
          await RestApiService().post('mobile-app/publish-meetups', jsonString);

      log('result : ${result.body}');
      if (result.statusCode == 200) {
        return json.decode(result.body)['data']['result'].toString();
      }
    } catch (e) {
      rethrow;
    }
    return '';
  }

  Future<void> uploadImageFirebase(
      List<Map<String, dynamic>> uploadImageDataList) async {
    await FirebaseFirestore.instance
        .collection('MEETUP_IMAGE')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({'images': FieldValue.arrayUnion(uploadImageDataList)},
            SetOptions(merge: true));
  }

  Future getDetailsFromCoordinates(LatLng latLng, String? apiKey) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey';
    final Response result = await RestApiService().get(url, forceUrl: true);
    if (result.statusCode == 200) {
      return json.decode(result.body)['results'];
    }
    return null;
  }

  Future getDetailsFromPalaceId(String? placeId, String? apiKey) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    final Response result = await RestApiService().get(url, forceUrl: true);
    if (result.statusCode == 200) {
      return json.decode(result.body)['result'];
    }
    return null;
  }
}
