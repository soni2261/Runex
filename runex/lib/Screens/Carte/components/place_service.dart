import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  //AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms

  static final String androidKey = 'AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms';
  static final String iosKey =
      'AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms'; //no ios key for now
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=fr-CA&components=country:ca&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();

      }
      if (result['status'] == 'ZERO_RESULTS') {
        print('AUCUNE VALEUR');
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
