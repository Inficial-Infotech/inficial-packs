import 'dart:io' as io;

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packs/modules/meetups/model/upload_image_data.dart';

part 'meetup_state.dart';

class MeetUpCubit extends Cubit<MeetUpState> {
  MeetUpCubit() : super(MeetUpState());

  void setCategory(String category) {
    emit(
      state.copyWith(
        category: category,
      ),
    );
  }

  void titleAndDes(String title, String des) {
    emit(
      state.copyWith(
        title: title,
        description: des,
      ),
    );
  }

  void setCoverImage(String coverImage, List<String> images) {
    emit(
      state.copyWith(
        coverImageURL: coverImage,
        imageURLs: images,
      ),
    );
  }

  void setDateAndTime(String startDate, String startTime, String endDate, String endTime) {
    emit(
      state.copyWith(
        startDate: startDate,
        startTime: startTime,
        endDate: endDate,
        endTime: endTime,
      ),
    );
  }

  void setGenderAndAeg(String gender, int minAge, int maxAge, int maxNumberOfParticipants) {
    emit(
      state.copyWith(
        gender: gender,
        minAge: minAge,
        maxAge: maxAge,
        maxNumberOfParticipants: maxNumberOfParticipants,
      ),
    );
  }

  Future<UploadImageDetails> uploadFile(String identifier, String imageName) async {
    try {
      final String? filePath = await FlutterAbsolutePath.getAbsolutePath(identifier);
      firebase_storage.UploadTask uploadTask;
      final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('images').child(imageName);
      uploadTask = ref.putFile(io.File(filePath!));
      final String imageUrl = await (await uploadTask).ref.getDownloadURL();
      return UploadImageDetails(
        imageURL: imageUrl,
        id: imageName.replaceAll('.jpg', ''),
      );
    } catch (e) {
      rethrow;
    }
  }
}
