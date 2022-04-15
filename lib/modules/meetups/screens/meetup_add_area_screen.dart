import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
import 'package:packs/modules/meetups/repository/meetup_repository.dart';
import 'package:packs/modules/meetups/screens/meetup_add_gender_age_screen.dart';
import 'package:packs/widgets/components/bar_button.dart';
import 'package:packs/widgets/components/explore_map.dart';

class MeetupAddAreaScreen extends StatefulWidget {
  const MeetupAddAreaScreen({Key? key}) : super(key: key);

  static const String id = 'MeetupAddAreaScreenState';

  @override
  _MeetupAddAreaScreenState createState() => _MeetupAddAreaScreenState();
}

class _MeetupAddAreaScreenState extends State<MeetupAddAreaScreen> {
  late MeetUpCubit meetUpCubit;
  late GoogleMapController mapController;
  LatLng initialPosition = const LatLng(37.773972, -122.431297);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String? area = 'Select City';
  LatLng? markerPosition;
  BitmapDescriptor? customIcon;
  String kGoogleApiKey = 'AIzaSyCB1I6C9IOuzLMSW0ddQXaok4kKv4siCQ4';

  @override
  void initState() {
    super.initState();
    meetUpCubit = BlocProvider.of<MeetUpCubit>(context);
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(Utils.mapStyle);
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            'assets/icon/marker.png')
        .then((BitmapDescriptor d) {
      customIcon = d;
    });
    final Position position = await _determinePosition();
    markerPosition = LatLng(position.latitude, position.longitude);
    final Marker marker = Marker(
        onTap: () {
          if (kDebugMode) {
            print('Tapped');
          }
        },
        draggable: true,
        markerId: const MarkerId('Marker'),
        position: LatLng(markerPosition!.latitude, markerPosition!.longitude),
        icon: customIcon!,
        onDragEnd: (LatLng newPosition) {
          markerPosition = newPosition;
          getUserLocation(newPosition);
        });
    markers[const MarkerId('Marker')] = marker;
    setState(() {});
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 1),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation(LatLng latLng) async {
    await context
        .read<MeetupRepository>()
        .getDetailsFromCoordinates(latLng, kGoogleApiKey)
        .then((response) {
      log(response.toString());
      if (response != null) {
        area = response[0]['formatted_address'].toString();
        (response as List).forEach((element) {
          if ((element['types'] as List).contains('route')) {
            area = element['formatted_address'].toString();
          }
        });
        setState(() {});
      }
    });
  }

  updateMarker() {
    final Marker marker = markers.values
        .toList()
        .firstWhere((Marker item) => item.markerId == const MarkerId('Marker'));

    Marker _marker = Marker(
        onTap: () {
          if (kDebugMode) {
            print('Tapped');
          }
        },
        draggable: true,
        markerId: const MarkerId('Marker'),
        position: LatLng(markerPosition!.latitude, markerPosition!.longitude),
        icon: customIcon!,
        onDragEnd: (LatLng newPosition) {
          markerPosition = newPosition;
          getUserLocation(newPosition);
        });

    setState(() {
      //the marker is identified by the markerId and not with the index of the list
      markers[const MarkerId('Marker')] = _marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PXBarButton(
                    icon: CupertinoIcons.back,
                    iconColor: Colors.black,
                    size: 50,
                    onTap: () {},
                  ),
                  PXBarButton(
                    icon: CupertinoIcons.clear,
                    iconColor: Colors.black,
                    size: 40,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pick area',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Drop a pin roughly where your meetup will take place. For safety reasons we don’t display exact meeting points. You can let people know where to meet later on. ',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icon/black_marker.png', height: 16),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Pick a rough area',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await PlacesAutocomplete.show(
                          context: context,
                          apiKey: kGoogleApiKey,
                          language: 'en',
                          types: [''],
                          components: [],
                          strictbounds: false,
                          mode: Mode.overlay, // Mode.fullscreen
                        ).then((Prediction? value) async {
                          await context
                              .read<MeetupRepository>()
                              .getDetailsFromPalaceId(
                                  value!.placeId, kGoogleApiKey)
                              .then((response) {
                            if (response != null) {
                              area = response['formatted_address'].toString();
                              markerPosition = LatLng(
                                  double.parse(response['geometry']['location']
                                          ['lat']
                                      .toString()),
                                  double.parse(response['geometry']['location']
                                          ['lng']
                                      .toString()));
                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: markerPosition!, zoom: 10),
                                ),
                              );
                              updateMarker();
                            }
                          });
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: PXColor.boxColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          area!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 280,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: initialPosition, zoom: 1),
                          markers: markers.values.toSet(),
                          myLocationEnabled: true,
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))
                            ..add(Factory<ScaleGestureRecognizer>(
                                () => ScaleGestureRecognizer()))
                            ..add(Factory<TapGestureRecognizer>(
                                () => TapGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer())),
                          onMapCreated: _onMapCreated,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Press and hold to drop your pin',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          onPressed: () {
                            if (area! == '') {
                              return;
                            } else {
                              meetUpCubit.setArea(
                                  area!,
                                  markerPosition!.latitude,
                                  markerPosition!.longitude);
                            }
                            navigateToMeetupAddGenderAgeScreen(context);
                          },
                          color: PXColor.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          child: const Text('Next'),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToMeetupAddGenderAgeScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext ctx) =>
            RepositoryProvider<MeetupRepository>.value(
          value: context.read<MeetupRepository>(),
          child: BlocProvider<MeetUpCubit>.value(
            value: BlocProvider.of<MeetUpCubit>(context),
            child: const MeetupAddGenderAgeScreen(),
          ),
        ),
      ),
    );
  }
}
