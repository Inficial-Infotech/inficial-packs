import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/model/upload_image_data.dart';
import 'package:packs/modules/meetups/repository/meetup_repository.dart';
import 'package:packs/modules/meetups/screens/meetup_add_agreement_screen.dart';

class MeetupAddCoverImageScreen extends StatefulWidget {
  const MeetupAddCoverImageScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupAddCoverImageScreen';

  @override
  _MeetupAddCoverImageScreenState createState() =>
      _MeetupAddCoverImageScreenState();
}

class _MeetupAddCoverImageScreenState extends State<MeetupAddCoverImageScreen> {
  late MeetUpCubit meetUpCubit;
  List<String> imageURLs = <String>[];
  int? selectIndex;
  final List<Map<String, dynamic>> uploadImageDataList = [];
  List<Asset> images = <Asset>[];
  bool isLoading = false;

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
            const Align(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Create Meet Up Cover Image Screen'),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            if (images.isNotEmpty)
              SizedBox(
                height: 150,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  children: List.generate(images.length, (int index) {
                    final Asset asset = images[index];
                    return GestureDetector(
                      onTap: () {
                        selectIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            AssetThumb(
                              asset: asset,
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blue),
                              ),
                              child: selectIndex == index
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 18,
                                    )
                                  : null,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            else
              const Center(
                child: Text(
                  'No Image Select',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            Align(
              child: CupertinoButton.filled(
                onPressed: () async {
                  try {
                    if (images.isEmpty) {
                      images = await loadAssets();
                      setState(() {});
                      return;
                    }

                    if (isLoading) {
                      setState(() {});
                      return;
                    }

                    if (uploadImageDataList.isEmpty) {
                      isLoading = true;
                      setState(() {});
                      await uploadImages(context);
                      setState(() {});
                      isLoading = false;
                    } else if (selectIndex != null) {
                      final List<String> tempImageList = <String>[];
                      tempImageList.addAll(imageURLs);
                      tempImageList.removeAt(selectIndex!);
                      meetUpCubit.setCoverImage(
                          imageURLs[selectIndex!], tempImageList);
                      navigateToMeetupAddAgreementScreen(context);
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: 'Something was wrong',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: PXColor.black,
                        textColor: PXColor.white);
                  }
                },
                child: images.isEmpty
                    ? const Text('Select Image')
                    : isLoading
                        ? const CupertinoActivityIndicator(color: PXColor.white)
                        : Text(uploadImageDataList.isEmpty ? 'Upload' : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Asset>> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(
      maxImages: 6,
      selectedAssets: images,
      materialOptions: const MaterialOptions(
        useDetailsView: true,
      ),
    );
    return resultList;
  }

  Future<void> uploadImages(BuildContext context) async {
    for (int i = 0; i < images.length; i++) {
      final UploadImageDetails uploadImageData = await meetUpCubit.uploadFile(
        images[i].identifier ?? '',
        images[i].name ?? '',
      );
      imageURLs.add(uploadImageData.imageURL);
      uploadImageDataList.add(uploadImageData.toJson());
    }
    await context
        .read<MeetupRepository>()
        .uploadImageFirebase(uploadImageDataList);
  }

  void navigateToMeetupAddAgreementScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) =>
            RepositoryProvider<MeetupRepository>.value(
          value: context.read<MeetupRepository>(),
          child: BlocProvider<MeetUpCubit>.value(
            value: BlocProvider.of<MeetUpCubit>(context),
            child: const MeetupAddAgreementScreen(),
          ),
        ),
      ),
    );
  }
}
