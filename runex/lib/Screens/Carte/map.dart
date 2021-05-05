import 'package:flutter/material.dart';
import 'package:runex/Screens/Carte/itineraire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MapGoogle extends StatefulWidget {
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  bool creerItineraire = false;
  Itineraire instance;

  @override
  initState() {
    super.initState();
    instance = Itineraire();
    setupItinerary();
  }

  Widget build(BuildContext context) {
    if (instance.initialPosition == null || instance.polyLines == null) {
      updateValues();
    }
    if (instance.initialPosition == null) {
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(instance.initialPosition.latitude,
                    instance.initialPosition.longitude),
                zoom: 10.0),
            markers: instance.markers != null
                ? Set<Marker>.from(instance.markers)
                : null,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: instance.polyLines != null
                ? Set<Polyline>.from(instance.polyLines)
                : null,

            // onCameraMove: onCameraMove,
          ),
          Positioned(
              left: 2,
              top: 15,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  size: 35.0,
                  color: Colors.grey[700],
                ),
                padding: EdgeInsets.all(7.0),
                shape: CircleBorder(),
              ))
        ],
      );
    }
  }

  setupItinerary() async {
    await instance.getCurrentLocation();
    //print('INITIAL POSITION');
    //print(instance.initialPosition);
    // print(instance.initialPosition.latitude);
    //
    await instance.sendRequest();

    updateValues();
  }

  //lorsque l'on a terminé de choisir les endroits à visiter
  void updateValues() {
    setState(() {});
  }
}
