import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runex/constants.dart';
import 'package:runex/Screens/Carte/components/address_search.dart';
import 'package:runex/Screens/Carte/components/place_service.dart';
import 'package:uuid/uuid.dart';

class Carte extends StatefulWidget {
  Carte({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  GoogleMapController mapController;

  final _destinationController = TextEditingController();

//sert a supprimer les ressources utilisées par l'objet TextEditingController lorsqu'il n'est plus utile
  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  int nbDestinationsAjoutees = 0;

  bool _isVisible = true;
  Icon _visibility = Icon(Icons.visibility);

  Icon _sportType = Icon(Icons.directions_run);

  List<Icon> _sportTypes = [
    Icon(
      Icons.directions_run,
    ),
    Icon(Icons.directions_walk),
    Icon(Icons.directions_bike)
  ];

  int _index = 0;

  bool itineraryIsVisible = false;

  bool editEnabled = true;

  bool widgetVisible = true;

//methode qui construit la carte
  @override
  Widget build(BuildContext context) {
    List<String> destinations = [
      '${_destinationController.text}'
    ]; // -- liste des adresses

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Carte'),
        backgroundColor: kPrimaryColor,
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.close),
        //       color: Colors.white,
        //       onPressed: () {
        //         Navigator.pop(context);
        //       })
        // ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RawMaterialButton(
                  onPressed: () {
                    _onModifyItiniraryPressed();
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(Icons.list_rounded),
                  padding: EdgeInsets.all(7.0),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
          Visibility(
            visible: itineraryIsVisible,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    AddressInput(
                      iconData: Icons.gps_fixed,
                      hintText: "Point de depart",
                      enabled: false,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      visible: widgetVisible,
                      child: Row(
                        children: [
                          //boite pour chercher l'itineraire
                          AddressInput(
                            controller: _destinationController,
                            iconData: Icons.place_sharp,
                            hintText: "Entrez une destination",
                            onTap: _search,
                            enabled: editEnabled,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _destinationController.text = '';
                                widgetVisible = false;
                              });
                            },
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //bouton pour ajouter des itinieraires. Dans cette version, il n'y a qu'une seule itineraire
                    FloatingActionButton(
                      backgroundColor: kPrimaryColor,
                      onPressed: () {
                        setState(() {
                          if (!widgetVisible) {
                            editEnabled = true;
                          }
                          widgetVisible = true;
                        });
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Row(
            children: [
              SizedBox(
                width: 1,
              ),
              sportsButton(),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              recenterButton(),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

// cette methode genere des suggestions de places lorsqu'on tape une lettre au clavier
  _search() async {
    final sessionToken = Uuid().v4();
    final Suggestion result = await showSearch(
        context: context, delegate: AddressSearch(sessionToken));
    // ca va changer le texte affiché dans la boîte itinéraire
    if (result != null) {
      setState(() {
        _destinationController.text = result.description;
        //destinations.add(_destinationController.text); //a ajouter s'il y a une liste d'itineraire dans la prochaine version
        editEnabled = false;
      });
    }
  }

//ouvre ou ferme la liste d'itinéraires sur la map
  void _onModifyItiniraryPressed() {
    setState(() {
      if (itineraryIsVisible == false) {
        itineraryIsVisible = true;
      } else {
        itineraryIsVisible = false;
      }
    });
  }

//dans la prochaine version, s'il y a l'option d'afficher notre localisation privée ou publique
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

//bouton de commencement
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

//bouton pour changer le sport
  Widget sportsButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        onPressed: () {
          changeSport();
        },
        elevation: 2.0,
        fillColor: Colors.white,
        child: _sportType,
        padding: EdgeInsets.all(7.0),
        shape: CircleBorder(),
      ),
    );
  }

// bouton pour recentrer la localisation de l'utilisateur
  Widget recenterButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(Icons.location_searching),
        padding: EdgeInsets.all(7.0),
        shape: CircleBorder(),
      ),
    );
  }

//rend la liste d'itineraire visible
  bool setItineraryVisible(bool itineraryIsVisible) {
    if (itineraryIsVisible) {
      return true;
    } else {
      return false;
    }
  }

//dans la prochaine version de l'app, s'il y a plusieurs destinations
  bool setVisibleDestination(int _visibleDestinations, int _destinationNumber) {
    if (_visibleDestinations >= _destinationNumber) {
      return true;
    } else {
      return false;
    }
  }

//dans la prochaine version de l'app, publique/privé
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

//change l'icone du type de sport (velo,marche,course)
  void changeSport() {
    setState(() {
      _sportType = _sportTypes[_index % 3];
      _index++;
    });
  }
}

//boîte d'un itinéraire
class AddressInput extends StatelessWidget {
  final IconData iconData;
  final TextEditingController controller;
  final String hintText;
  final Function onTap;
  final bool enabled;

  const AddressInput({
    Key key,
    this.iconData,
    this.controller,
    this.hintText,
    this.onTap,
    this.enabled,
  }) : super(key: key);

  //methode qui construit la boîte d'itinéraire
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          this.iconData,
          size: 18,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 35.0,
            width: MediaQuery.of(context).size.width / 1.4,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[100]),
            child: TextField(
              controller: controller,
              onTap: onTap,
              enabled: enabled,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
