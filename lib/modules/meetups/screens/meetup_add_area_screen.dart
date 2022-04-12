import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/modules/meetups/cubit/meetup_cubit.dart';
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
  LatLng initialPosition = LatLng(37.773972, -122.431297);
  List<Marker> customMarkers = [];
  String? area = "Select City";
  LatLng? markerPosition;
  BitmapDescriptor? customIcon;


  @override
  void initState() {
    super.initState();
    meetUpCubit = BlocProvider.of<MeetUpCubit>(context);
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(Utils.mapStyle);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
        'assets/icon/marker.png')
        .then((d) {
      customIcon = d;
    });
    // TODO: Nicht auf die eigene, sondern auf die Position des ersten Deals gehen
    Position position = await _determinePosition();
    markerPosition = LatLng(position.latitude, position.longitude);
  Marker marker =  Marker(
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        markerId: MarkerId('Marker'),
        position: LatLng(markerPosition!.latitude, markerPosition!.longitude),
        icon: customIcon!,
        onDragEnd: ((newPosition) {
          // markerPosition = newPosition;
          getUserLocation(newPosition);
          print(newPosition.latitude);
          print(newPosition.longitude);
        }));
    customMarkers.add(marker);
    setState(() {

    });
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  getUserLocation(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print(placemarks.first.toJson());
    area = placemarks.first.subLocality.toString() + ", " +placemarks.first.street.toString() + ", " + placemarks.first.locality.toString();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:SafeArea(

        child: Container(
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
                    onTap: ()  {

                    },
                  ),
                  PXBarButton(
                    icon: CupertinoIcons.clear,
                    iconColor: Colors.black,
                    size: 40,
                    onTap: ()  {
                      Navigator.pop(context);
                    },
                  ),

                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pick area',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
                    const SizedBox(height: 15,),
                   const Text('Drop a pin roughly where your meetup will take place. For safety reasons we don’t display exact meeting points. You can let people know where to meet later on. ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                   const SizedBox(height: 20,),
                     Row(
                      children: [
                         Image.asset('assets/icon/black_marker.png',height: 16),
                         const SizedBox(width: 10,),
                         const Text('Pick a rough area',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),                      ],
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: PXColor.boxColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))

                      ),
                      padding: EdgeInsets.all(20),
                      child: Text(area!,),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      height: 280,
                      
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(target: initialPosition, zoom: 1),
                          markers: customMarkers.toSet(),
                          myLocationEnabled: true,
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                            ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                          onMapCreated: _onMapCreated,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    const Text('Press and hold to drop your pin',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                    const SizedBox(height: 50,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(onPressed: () {
                          navigateToMeetupAddGenderAgeScreen(context);
                        } ,color: PXColor.black,borderRadius: const BorderRadius.all(Radius.circular(25)),child: const Text('Next'),))
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
        builder: (BuildContext ctx) => BlocProvider<MeetUpCubit>.value(
          value: BlocProvider.of<MeetUpCubit>(context),
          child: const MeetupAddGenderAgeScreen(),
        ),
      ),
    );
  }

}
