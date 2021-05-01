import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/services/base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runex/requests/google_maps_requests.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Itineraire {
  double temps;
  double distanceTot = 0;
  double elevation;
  double speedInMps;
  LatLng _initialPosition;
  LatLng _lastPosition = LatLng(45.5048,
      -73.5772); // dummy data, should be activated when we press the start button
  bool locationServiceActive = true;
  GoogleMapController mapController;
  GoogleMapsServices googleMapsServices = GoogleMapsServices();
  final Set<Marker> markers = {};
  final Set<Polyline> polyLines = {};

  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;

  GoogleMapsServices get ggoogleMapsServices => googleMapsServices;
  GoogleMapController get gmapController => mapController;

  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  List<String> adresses;
  List<LatLng> endroits = [
    LatLng(45.5125, -73.5485),
    LatLng(45.5155, -73.5623),
    LatLng(45.5600, -73.5630)
  ];

  bool stopispressed = false;
  bool startispressed = false;
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 5);

  Itineraire();

  List<LatLng> convertToLatLng(List points) {
    print('ON CONVERTI EN LATLNG');
    List<LatLng> result = <LatLng>[];
    print(points.length);
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    print(result);
    print(result.length);
    return result;
  }

// !DECODE POLY
  List decodePoly(String poly) {
    print('ON DÉCODE LE POLY');
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    return lList;
  }

//send request of itinary between two points
  void sendRequest() async {
    for (int i = 0; i < endroits.length; i++) {
      String route;
      Map values;
      _addMarker(endroits[i]);

      if (i == 0) {
        values = await googleMapsServices.getRouteCoordinates(
            _initialPosition, endroits[i], distanceTot);
      } else {
        values = await googleMapsServices.getRouteCoordinates(
            endroits[i - 1], endroits[i], distanceTot);
      }

      distanceTot =
          distanceTot + values["routes"][0]["legs"][0]["distance"]["value"];

      route = values["routes"][0]["overview_polyline"]["points"];

      createRoute(route);
    }
  }

  // create markers for the important positions
  void _addMarker(LatLng location) {
    markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        // infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  // create an itinary with a combination of points
  void createRoute(String encondedPoly) {
    print('ON CRÉER LE POLYLINE');
    polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 5,
        points: convertToLatLng(decodePoly(encondedPoly)),
        color: Colors.blue));

    print('la distannce totale est $distanceTot');
    // elevation = googleMapsServices.getElevation(_initialPosition) as double;
    //print('lélevation init est $elevation');
  }

  // get the current location of the user
  Future<void> getCurrentLocation() async {
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    this._initialPosition = LatLng(position.latitude, position.longitude);
    print(
        "the latitude is: ${position.latitude} and th longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
    locationController.text = placemark[0].name;
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getCurrentSpeed() {
    // var options =
    //     LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((position) {
      speedInMps = position.speed; // this is your speed
      print('la vitesse est $speedInMps');
    });
  }

  void startTimer() {
    Timer(dur, keepRunning());
  }

  keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
  }

  void startTopWatch() {
    swatch.start();
    startTimer();
  }

  void stopsTopWatch() {
    stopispressed = true;
    temps; // commande qui va arrêter le swatch et donner la valeur à cette variable
  }
}
