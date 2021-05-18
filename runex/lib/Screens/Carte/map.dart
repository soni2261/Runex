import 'package:date_format/date_format.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:runex/Screens/Carte/components/address_search.dart';
import 'package:runex/Screens/Carte/components/place_service.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:runex/requests/google_maps_requests.dart';
import 'package:runex/Screens/Carte/components/addressInput.dart';
import 'package:uuid/uuid.dart';

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
  List<LatLng> positions = [];
  LatLng _lastPosition = LatLng(45.5048,
      -73.5772); // dummy data, should be activated when we press the start button
  bool locationServiceActive = true;
  GoogleMapController mapController;
  GoogleMapsServices googleMapsServices = GoogleMapsServices();
  final Set<Marker> markers = {};
  final Set<Polyline> polyLines = {};
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  Timer timer;
  List<String> adresses;
  List<IconData> typeSport = [
    Icons.directions_run,
    Icons.directions_walk,
    Icons.directions_bike
  ];
  int sportChoisi = 0;

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

  final _destinationController = TextEditingController();
  List<String> destinations = [];

  List<Coordinates> coordonneesEndroits = [];

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

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
                      child: AddressInput(
                        controller: _destinationController,
                        iconData: Icons.place_sharp,
                        hintText: "Entrez une destination",
                        onTap: _search,
                        enabled: true,
                      ),
                      // child: TextField(
                      //   style: TextStyle(color: Colors.black),
                      //   decoration: InputDecoration(
                      //       icon: IconButton(
                      //           icon: Icon(
                      //             Icons.arrow_back,
                      //             color: Colors.grey[800],
                      //           ),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           }),
                      //       suffixIcon: Container(
                      //         child: Icon(
                      //           Icons.search,
                      //           color: Colors.grey[800],
                      //         ),
                      //       ),
                      //       border: InputBorder.none),
                      // ),
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
                      onPressed: () {
                        setState(() {
                          sportChoisi++;
                          sportChoisi = sportChoisi % 3;
                        });
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        typeSport[sportChoisi],
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

  Future<void> convertirAdresseLatLng() async {
    for (int i = 0; i < destinations.length; i++) {
      final query = destinations[i];
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      coordonneesEndroits.add(first.coordinates);
      print(coordonneesEndroits[0]);
    }
  }

  _search() async {
    final sessionToken = Uuid().v4();
    final Suggestion result = await showSearch(
        context: context, delegate: AddressSearch(sessionToken));
    // ca va changer le texte affiché dans la boîte itinéraire
    if (result != null) {
      setState(() {
        _destinationController.text = result.description;
        destinations.add(_destinationController
            .text); //a ajouter s'il y a une liste d'itineraire dans la prochaine version
      });
    }
  }

  //va chercher la position actuelle de l'utilisateur et créer un itinéraire
  setupItinerary() async {
    await getCurrentLocation();
    //print('INITIAL POSITION');
    //print(instance.initialPosition);
    // print(instance.initialPosition.latitude);
    //
    await sendRequest();

    updateValues();
  }

  //lorsque l'on a terminé de choisir les endroits à visiter, on met à jour les données de la map
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

  LatLng get lastPosition => _lastPosition;

  GoogleMapsServices get ggoogleMapsServices => googleMapsServices;
  GoogleMapController get gmapController => mapController;

  Itineraire() {
    _initialPosition = null;
    // getCurrentCity();
  }

  //converti la liste de points en une liste de coordonnées
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

  // décode le polyline
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

  //fait une demande pour créer un itinéraire entre deux points
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

      // distanceTot =
      //     distanceTot + values["routes"][0]["legs"][0]["distance"]["value"];

      route = values["routes"][0]["overview_polyline"]["points"];

      createRoute(route);
    }
  }

  // crée un marker à la position
  void _addMarker(LatLng location) {
    markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        // infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  // crée un itinéraire à partir d'une liste de points
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

  // cherche la position actuelle de l'utilisateur
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
      positions.add(_currentPosition);
    }
    locationController.text = placemark[0].name;
  }

  // camera mouvement
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  // google map contrôle
  void onCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //cherche la vitesse de l'utilisateur
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

  //méthodes en boucle pour mesurer les données durant l'entrainement en cours
  void startTimer() {
    if (_currentPosition == _lastPosition) {
      termine = true;
    }
    timer = null;
    timer = Timer.periodic(dur, (Timer t) => keepRunning());
    // Timer(dur, keepRunning());
  }

  keepRunning() {
    // if (swatch.isRunning && !termine && commence) {
    getCurrentSpeed();
    getCurrentElevation();
    getCurrentLocation();
    // }
    // else {
    //   stopsTopWatch();
    // }
  }

  //lorsque l'on appuie sur le bouton START pour commencer l'entrainement
  void startTopWatch() {
    commence = true;
    termine = false;
    startTime = DateTime.now();
    swatch.start();
    setState(() {
      buttonText = "STOP";
      buttonColor = Colors.red;
    });
    // const oneSec = const Duration(seconds: 1);
    // new Timer.periodic(oneSec, (Timer t) => print('hi!'));
    startTimer();
  }

//lorsque l'on appuie sur le bouton STOP pour arrêter l'entrainement

  void stopsTopWatch() {
    timer.cancel();
    swatch.stop();

    duree = swatch.elapsedMilliseconds;
    swatch.reset();
    commence = false;
    termine = true;
    endTime = DateTime.now();
    Map historiqueItem = archiverEntrainement();
    saveData(utilisateur, historiqueItem);

    setState(() {
      buttonText = "START";
      buttonColor = Colors.green[400];
    }); // commande qui va arrêter le swatch et donner la valeur à cette variable

    // await archiverEntrainement();
  }

  //demande l'élevation de la position actuelle
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

    String sport;

    if (sportChoisi == 0) {
      sport = 'course';
    } else if (sportChoisi == 1) {
      sport = 'marche';
    } else {
      sport = 'velo';
    }

    for (int i = 0; i < positions.length - 1; i++) {
      distanceTot += calculerDistance(
          positions[i].latitude,
          positions[i].longitude,
          positions[i + 1].latitude,
          positions[i + 1].longitude);
    }

    Map historiqueItem = {
      'name': name,
      'sport': sport,
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

  double calculerDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void saveData(Utilisateur utilisateur, Map historiqueItem) {
    DatabaseService(uid: utilisateur.uid).addHistorique(
        historiqueItem: historiqueItem, utilisateur: utilisateur);
  }
}
