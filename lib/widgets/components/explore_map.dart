import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:packs/models/DealModel.dart';

class ExploreMap extends StatefulWidget {
  final List<DealModel> dealModels;

  ExploreMap({required this.dealModels});

  @override
  State<StatefulWidget> createState() {
    return _ExploreMapState();
  }
}

class _ExploreMapState extends State<ExploreMap> {
  late GoogleMapController mapController;
  LatLng initialPosition = LatLng(37.773972, -122.431297);
  List<Marker> customMarkers = [];

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(Utils.mapStyle);

    // TODO: Nicht auf die eigene, sondern auf die Position des ersten Deals gehen
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (final deal in widget.dealModels) {
      final geoloc = deal.geoloc;
      if (geoloc != null) {
        customMarkers.add(
          Marker(
            markerId: MarkerId(deal.uid!),
            position: LatLng(geoloc.lat, geoloc.lng),
            consumeTapEvents: true,
            onTap: () {
              print(deal.name);
            },
          ),
        );
      }
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: initialPosition, zoom: 1),
      mapType: MapType.normal,
      markers: customMarkers.toSet(),
      myLocationEnabled: true,
      // gestureRecognizers: Set()
      //   ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
      //   ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
      //   ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
      //   ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
      onMapCreated: _onMapCreated,
    );
  }
}

class Utils {
  static String mapStyle = '''
    [
    {
        "featureType": "administrative",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "hue": "#0066ff"
            },
            {
                "saturation": 74
            },
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            },
            {
                "weight": 0.6
            },
            {
                "saturation": -85
            },
            {
                "lightness": 61
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "color": "#5f94ff"
            },
            {
                "lightness": 26
            },
            {
                "gamma": 5.86
            }
        ]
    }
]
  ''';
}
