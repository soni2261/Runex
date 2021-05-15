import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:runex/components/text_field_container.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:runex/requests/google_maps_requests.dart';

// import 'package:runex/Screens/Carte/carte.dart';

class MapGoogle extends StatefulWidget {
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  bool creerItineraire = false;
  Utilisateur utilisateur;
  bool commence = false;
  bool termine = false;
  Color buttonColor = Colors.green[400];
  String buttonText = "START";
  var swatch = Stopwatch();
  int duree;
  DateTime startTime;
  DateTime endTime;
  double distanceTot = 0;
  List<double> elevation = List<double>();
  List<double> speedInMps = List<double>();
  LatLng _city = LatLng(45.5048, -73.5772);
  LatLng _initialPosition;
  LatLng _currentPosition;
  LatLng _lastPosition = LatLng(45.5048,
      -73.5772); // dummy data, should be activated when we press the start button
  bool locationServiceActive = true;
  GoogleMapController mapController;
  GoogleMapsServices googleMapsServices = GoogleMapsServices();
  final Set<Marker> markers = {};
  final Set<Polyline> polyLines = {};
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  List<String> adresses;

  //liste fictive d'endroits à connecter avec la vraie
  List<LatLng> endroits = [
    LatLng(45.5125, -73.5485),
    LatLng(45.5155, -73.5623),
    LatLng(45.5600, -73.5630)
  ];

  bool stopispressed = false;
  bool startispressed = false;
  final dur = const Duration(seconds: 5);
  int nbDestinationsAjoutees = 0;

  @override
  initState() {
    super.initState();
    // instance = Itineraire();
    setupItinerary();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    utilisateur = Provider.of<Utilisateur>(context);
    if (initialPosition == null && polyLines == null) {
      updateValues();
    }
    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData && initialPosition != null) {
            utilisateur = snapshot.data;
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTapDown: (info) {},
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(initialPosition.latitude,
                              initialPosition.longitude),
                          zoom: 10.0),
                      markers:
                          markers != null ? Set<Marker>.from(markers) : null,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      polylines: polyLines != null
                          ? Set<Polyline>.from(polyLines)
                          : null,

                      // onCameraMove: onCameraMove,
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      // width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            icon: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.grey[800],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            suffixIcon: Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.grey[800],
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),

                  // Positioned(
                  //     left: 2,
                  //     top: 15,
                  //     child: RawMaterialButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       elevation: 2.0,
                  //       fillColor: Colors.white,
                  //       child: Icon(
                  //         Icons.arrow_back,
                  //         size: 30.0,
                  //         color: Colors.grey[700],
                  //       ),
                  //       padding: EdgeInsets.all(7.0),
                  //       shape: CircleBorder(),
                  //     )),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RawMaterialButton(
                          onPressed: () {
                            if (!commence) {
                              startTopWatch();
                            } else {
                              stopsTopWatch();
                            }
                          },
                          elevation: 2.0,
                          fillColor: buttonColor,
                          child: Text(
                            buttonText,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16),
                          ),
                          padding: EdgeInsets.all(30.0),
                          shape: CircleBorder(),
                        )),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 28,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.gps_fixed,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.all(12.0),
                      shape: CircleBorder(),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 28,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.directions_bike,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.all(12.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Center(
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            );
          }
        });
  }

  setupItinerary() async {
    await getCurrentLocation();
    //print('INITIAL POSITION');
    //print(instance.initialPosition);
    // print(instance.initialPosition.latitude);
    //
    await sendRequest();

    updateValues();
  }

  //lorsque l'on a terminé de choisir les endroits à visiter
  void updateValues() {
    setState(() {});
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  LatLng get initialPosition {
    // do {} while (_initialPosition == null);
    return _initialPosition;
  }

  LatLng get initialPositionCity {
    // do {} while (_initialPosition == null);
    return _city;
  }

  LatLng get lastPosition => _lastPosition;

  GoogleMapsServices get ggoogleMapsServices => googleMapsServices;
  GoogleMapController get gmapController => mapController;

  Itineraire() {
    _initialPosition = null;
    // getCurrentCity();
  }

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
  Future<void> sendRequest() async {
    for (int i = 0; i < endroits.length && _initialPosition != null; i++) {
      print('LE I EST $i');
      String route;
      Map values;
      _addMarker(endroits[i]);

      if (i == 0) {
        values = await googleMapsServices.getRouteCoordinates(
            _initialPosition, endroits[i], distanceTot);

        print('POSITION $i = $_initialPosition');
      } else {
        values = await googleMapsServices.getRouteCoordinates(
            endroits[i - 1], endroits[i], distanceTot);
        print('POSITION $i = ${endroits[i - 1]}');
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
  void createRoute(String encondedPoly) async {
    print('ON CRÉER LE POLYLINE');
    polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 5,
        points: convertToLatLng(decodePoly(encondedPoly)),
        color: Colors.blue));

    print('la distannce totale est $distanceTot');

    print('lélevation init est $elevation');
  }

  // get the current location of the user
  Future<void> getCurrentLocation() async {
    print("GET USER METHOD RUNNING =========");

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    if (!commence) {
      this._initialPosition = LatLng(position.latitude, position.longitude);
    }
    if (commence) {
      this._currentPosition = LatLng(position.latitude, position.longitude);
    }
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
    double speedTemp = 0;
    var options =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    Geolocator().getPositionStream(options).listen((position) {
      speedTemp = position.speed; // this is your speed

      print('la vitesse est $speedInMps');
    });
    speedInMps.add(speedTemp);
  }

  void startTimer() {
    if (_currentPosition == _lastPosition) {
      termine = true;
    }
    Timer(dur, keepRunning());
  }

  keepRunning() {
    if (swatch.isRunning && !termine) {
      getCurrentSpeed();
      getCurrentElevation();
      getCurrentLocation();
      startTimer();
    } else {
      stopsTopWatch();
    }
  }

  //lorsque l'on appuie sur le bouton START
  void startTopWatch() {
    commence = true;
    termine = false;
    startTime = DateTime.now();
    swatch.start();
    setState(() {
      buttonText = "STOP";
      buttonColor = Colors.red;
    });
    startTimer();
  }

//lorsque l'on appuie sur le bouton STOP
  Future stopsTopWatch() async {
    commence = false;
    termine = true;
    endTime = DateTime.now();
    swatch.stop();
    duree = swatch.elapsedMilliseconds;
    Map historiqueItem = archiverEntrainement();
    saveData(utilisateur, historiqueItem);
    // swatch.reset();

    setState(() {
      buttonText = "START";
      buttonColor = Colors.green[400];
    }); // commande qui va arrêter le swatch et donner la valeur à cette variable

    // await archiverEntrainement();
  }

  Future<void> getCurrentElevation() async {
    double elevationTemps;

    elevationTemps = await googleMapsServices.getElevation(_currentPosition);

    elevation.add(elevationTemps);
  }

  //Pour faire la transition à l'historique et mettre les données dans la firebase
  Map archiverEntrainement() {
    String name;
    if (endTime.day == 12 || endTime.day == 13) {
      name = formatDate(endTime, [M, ' ', endTime.day.toString(), 'th, ', yyyy])
          .toString();
    } else if (endTime.day % 10 == 1) {
      name = formatDate(endTime, [M, ' ', endTime.day.toString(), 'st, ', yyyy])
          .toString();
    } else if (endTime.day % 10 == 2) {
      name = formatDate(endTime, [M, ' ', endTime.day.toString(), 'nd, ', yyyy])
          .toString();
    } else if (endTime.day % 10 == 3) {
      name = formatDate(endTime, [M, ' ', endTime.day.toString(), 'rd, ', yyyy])
          .toString();
    } else {
      name = formatDate(endTime, [M, ' ', endTime.day.toString(), 'th, ', yyyy])
          .toString();
    }

    Map historiqueItem = {
      'name': name,
      'sport': 'velo',
      'duree': duree,
      'startTime': formatDate(
          startTime, [yyyy, '-', mm, '-', dd, ' à ', HH, ':', nn, ':', ss]),
      'endTime': formatDate(
          endTime, [yyyy, '-', mm, '-', dd, ' à ', HH, ':', nn, ':', ss]),
      'distance': distanceTot,
      'elevation': elevation,
      'vitesse': speedInMps,
    };
    return historiqueItem;
  }

  void saveData(Utilisateur utilisateur, Map historiqueItem) {
    DatabaseService(uid: utilisateur.uid).addHistorique(
        historiqueItem: historiqueItem, utilisateur: utilisateur);
  }
}
