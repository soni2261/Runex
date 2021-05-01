import 'package:flutter/material.dart';
import 'package:runex/Screens/Carte/components/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == "" ? null : apiClient.fetchSuggestions(query),
        builder: (context, snapshot) => query == ""
            ? Container(
                child: Text("Entrez votre addresse"),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, i) => ListTile(
                      title: Text((snapshot.data[i] as Suggestion).description),
                      onTap: () {
                        print((snapshot.data[i] as Suggestion).placeId);
                        close(context, snapshot.data[i]);
                      },
                    ),
                    itemCount: snapshot.data.length,
                  )
                : Container(
                    child: Center(child: CircularProgressIndicator()),
                  ));
  }
}
