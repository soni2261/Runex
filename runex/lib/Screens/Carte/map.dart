import 'package:flutter/material.dart';
import 'package:runex/Screens/Carte/itineraire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';

class MapGoogle extends StatefulWidget {
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  Itineraire instance;

  @override
  initState() {
    super.initState();

    instance = Itineraire();
    // setupItinerary();
  }

  Widget build(BuildContext context) {
    setupItinerary();

    //final appState = Provider.of<AppState>(context);
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
          polylines: instance.polyLines,

          // onCameraMove: onCameraMove,
        ),
      ],
    );
  }

  setupItinerary() async {
    await instance.getCurrentLocation();
    print('INITIAL POSITION');
    print(instance.initialPosition);
    print(instance.initialPosition.latitude);
    instance.sendRequest();
    instance.getCurrentSpeed();
  }
}
