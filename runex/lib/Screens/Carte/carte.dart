import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runex/constants.dart';
import 'package:search_map_place/search_map_place.dart';

class Carte extends StatefulWidget {
  Carte({Key key}) : super(key: key);

  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  GoogleMapController mapController;

  bool _isVisible = true;
  Icon _visibility = Icon(Icons.visibility);

  Icon _sportType = Icon(Icons.directions_run);

  List<Icon> _sportTypes = [
    Icon(Icons.directions_run),
    Icon(Icons.directions_walk),
    Icon(Icons.directions_bike)
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Carte'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            searchBar(),
            SizedBox(
              height: 500,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                visibilityButton(),
                SizedBox(
                  width: 20,
                ),
                startButton(),
                SizedBox(
                  width: 20,
                ),
                sportsButton(),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return SearchMapPlaceWidget(
      hasClearButton: true,
      placeType: PlaceType.address,
      placeholder: 'Rechercher',
      apiKey:
          'AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms', //enable Places for Google Maps
      onSelected: (Place place) async {
        Geolocation geolocation = await place.geolocation;
        mapController
            .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
        mapController
            .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
      },
    );
  }

  Widget visibilityButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: const ShapeDecoration(
          color: kPrimaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {
            changeVisibility();
          },
          icon: _visibility,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget startButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const ShapeDecoration(
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(),
          ),
          child: IconButton(
            onPressed: () {},
            splashRadius: 50.0,
            iconSize: 40,
            icon: Icon(Icons.arrow_right),
            color: kPrimaryLightColor,
          ),
        ),
      ),
    );
  }

  Widget sportsButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: const ShapeDecoration(
          color: kPrimaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {
            changeSport();
          },
          icon: _sportType,
          color: Colors.black,
        ),
      ),
    );
  }

  void changeVisibility() {
    setState(() {
      if (_isVisible) {
        _isVisible = false;
        _visibility = Icon(Icons.visibility_off);
      } else {
        _isVisible = true;
        _visibility = Icon(Icons.visibility);
      }
    });
  }

  void changeSport() {
    setState(() {
      _sportType = _sportTypes[_index % 3];
      _index++;
    });
  }
}
