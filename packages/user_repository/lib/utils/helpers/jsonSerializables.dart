import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? dateTimeFromJson(Timestamp? timestamp) {
  if (timestamp == null) {
    return null;
  }
  return timestamp.toDate();
}

DateTime? dateTimeToJson(DateTime? date) {
  if (date == null) {
    return null;
  }
  return date;
}
