// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:search_map_place/search_map_place.dart';

// class Search extends StatefulWidget {
//   //String value;

//   Search({Key key}) : super(key: key);

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   GoogleMapController mapController;

//   LatLng latLngAdress;

//   @override
//   Widget build(BuildContext context) {
//     //var width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         title: Text('Carte'),
//         backgroundColor: Colors.transparent,
//         actions: [
//           IconButton(
//               icon: Icon(Icons.close),
//               color: Colors.white,
//               onPressed: () {
//                 Navigator.pop(context,latLngAdress);
//               })
//         ],
//       ),
//       body: SearchMapPlaceWidget(
//         hasClearButton: true,
//         placeType: PlaceType.address,
//         placeholder: 'Rechercher',
//         language: "fr",
//         location: LatLng(45.501690, -73.567253), //montreal
//         radius: 5000000,
//         strictBounds: true,
//         //darkMode: true,
//         apiKey:
//             'AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms', //enable Places for Google Maps
//         onSelected: (Place place) async {
//           Geolocation geolocation = await place.geolocation;
//           // mapController
//           //     .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
//           // mapController
//           //     .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
//           print(geolocation.coordinates);
//           latLngAdress = geolocation.coordinates;
//         },
//       ),
//     );
//   }
// }
