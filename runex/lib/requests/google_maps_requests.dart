import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms";

class GoogleMapsServices {
  Future<Map> getRouteCoordinates(LatLng l1, LatLng l2, distance) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    print('ON A OBTENU LE STRING');
    Map values = jsonDecode(response.body);
    print(response.body);

    print('ON DÉCODE LE STRING');
    return values;
  }

  Future<double> getElevation(LatLng l1) async {
    String url =
        "https://maps.googleapis.com/maps/api/elevation/json?locations=${l1.latitude},${l1.longitude}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    print('ON A OBTENU LE STRING');
    Map values = jsonDecode(response.body);
    print(response.body);

    print('ON DÉCODE LE STRING');
    return values["results"][0]["elevation"];
  }
}
