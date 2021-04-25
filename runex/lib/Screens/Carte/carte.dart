import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runex/constants.dart';
import 'package:search_map_place/search_map_place.dart';

import 'package:runex/Screens/Carte/components/textfield.dart';

import 'package:runex/components/rounded_text_button.dart';

import 'package:runex/Screens/Carte/components/search.dart';
//-----------------------------
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

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  _search() async {
                            final sessionToken = Uuid().v4();
                            final Suggestion result = await showSearch(
                                context: context,
                                delegate: AddressSearch(sessionToken));
                            if (result != null) {
                              setState(() {
                                _destinationController.text =
                                    result.description;
                              });
                            }
                          }

  //String text = 'text';

  // String _currentAddress;

  // final startAddressController = TextEditingController();
  // final destinationAddressController1 = TextEditingController();
  // final destinationAddressController2 = TextEditingController();
  // final destinationAddressController3 = TextEditingController();
  // final destinationAddressController4 = TextEditingController();
  // final destinationAddressController5 = TextEditingController();
  // final destinationAddressController6 = TextEditingController();

  // String _startAddress = '';
  // String _destinationAddress = '';
  // String _placeDistance;

  int nbDestinationsAjoutees = 0;

  List<String> destinations = [' ', ' ', ' ', ' ', ' ', ' '];

  bool _isVisible = true;
  Icon _visibility = Icon(Icons.visibility);

  Icon _sportType = Icon(Icons.directions_run);

  List<Icon> _sportTypes = [
    Icon(Icons.directions_run),
    Icon(Icons.directions_walk),
    Icon(Icons.directions_bike)
  ];

  int _index = 0;

  // int _visibleDestinations = 1;

  bool itineraryIsVisible = false;

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;

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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: kPrimaryColor,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.list_rounded),
                    color: kPrimaryLightColor,
                    onPressed: () {
                      _onModifyItiniraryPressed();
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Ink(
              //     decoration: const ShapeDecoration(
              //       color: kPrimaryColor,
              //       shape: CircleBorder(),
              //     ),
              //     child: IconButton(
              //       icon: Icon(Icons.star),
              //       color: kPrimaryLightColor,
              //       onPressed: () {
              //         //_onModifyItiniraryPressed();
              //       },
              //     ),
              //   ),
              // ),
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
                    Row(
                      children: [
                        AddressInput(
                          controller: _destinationController,
                          iconData: Icons.place_sharp,
                          hintText: "Entrez une destination",
                          onTap: _search, 
                        ),
                        InkWell(
                            child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 28,
                        )),
                      ],
                    ),
                    // Visibility(
                    //   visible: true,
                    //   child: //searchBar(),

                    //       _textField(
                    //           label: 'Destination',
                    //           hint: 'Choose destination',
                    //           initialValue: destinations[1],
                    //           prefixIcon: Icon(Icons.looks_one),
                    //           controller: destinationAddressController1,
                    //           width: width,
                    //           locationCallback: (String value) {
                    //             //_awaitReturnValueFromSecondScreen(context, value);

                    //             //print(context);

                    //             //value = context;

                    //             // setState(() {
                    //             //   // destinations[1] = value;
                    //             //   // print(destinations);

                    //             //   Navigator.of(context).push(MaterialPageRoute(
                    //             //     builder: (context) => Search(),
                    //             //   ));

                    //             // });
                    //           }),
                    // ),
                    // SizedBox(height: 10),

                    // // Expanded(
                    // //   child: ListView.builder(
                    // //     scrollDirection: Axis.vertical,
                    // //     itemCount: nbDestinationsAjoutees,
                    // //     itemBuilder: (context, index) {
                    // //       return createDestination(nbDestinationsAjoutees);
                    // //     },
                    // //   ),
                    // // ),

                    // Visibility(
                    //   visible: setVisibleDestination(_visibleDestinations, 2),
                    //   child: //searchBar(),
                    //       _textField(
                    //           label: 'Destination',
                    //           hint: 'Choose destination',
                    //           initialValue: '',
                    //           prefixIcon: Icon(Icons.looks_two),
                    //           controller: destinationAddressController2,
                    //           width: width,
                    //           locationCallback: (String value) {
                    //             setState(() {
                    //               destinations[2] = value;
                    //               print(value);
                    //             });
                    //           }),
                    // ),
                    // SizedBox(height: 10),

                    // Visibility(
                    //   visible: setVisibleDestination(_visibleDestinations, 3),
                    //   child: _textField(
                    //       label: 'Destination',
                    //       hint: 'Choose destination',
                    //       initialValue: '',
                    //       prefixIcon: Icon(Icons.looks_3),
                    //       controller: destinationAddressController3,
                    //       width: width,
                    //       locationCallback: (String value) {
                    //         setState(() {
                    //           destinations[3] = value;
                    //         });
                    //       }),
                    // ),
                    // SizedBox(height: 10),
                    // Visibility(
                    //   visible: setVisibleDestination(_visibleDestinations, 4),
                    //   child: _textField(
                    //       label: 'Destination',
                    //       hint: 'Choose destination',
                    //       initialValue: '',
                    //       prefixIcon: Icon(Icons.looks_4),
                    //       controller: destinationAddressController4,
                    //       width: width,
                    //       locationCallback: (String value) {
                    //         setState(() {
                    //           destinations[4] = value;
                    //         });
                    //       }),
                    // ),
                    // SizedBox(height: 10),
                    // Visibility(
                    //   visible: setVisibleDestination(_visibleDestinations, 5),
                    //   child: _textField(
                    //       label: 'Destination',
                    //       hint: 'Choose destination',
                    //       initialValue: '',
                    //       prefixIcon: Icon(Icons.looks_5),
                    //       controller: destinationAddressController5,
                    //       width: width,
                    //       locationCallback: (String value) {
                    //         setState(() {
                    //           destinations[5] = value;
                    //         });
                    //       }),
                    // ),
                    // SizedBox(height: 10),
                    // Visibility(
                    //   visible: setVisibleDestination(_visibleDestinations, 6),
                    //   child: _textField(
                    //       label: 'Destination',
                    //       hint: 'Choose destination',
                    //       initialValue: '',
                    //       prefixIcon: Icon(Icons.looks_6),
                    //       controller: destinationAddressController6,
                    //       width: width,
                    //       locationCallback: (String value) {
                    //         setState(() {
                    //           destinations[6] = value;
                    //         });
                    //       }),
                    // ),
                    // SizedBox(height: 10),

                    // // Visibility(
                    // //   visible: _placeDistance == null ? false : true,
                    // //   child: Text(
                    // //     'DISTANCE: $_placeDistance km',
                    // //     style: TextStyle(
                    // //       fontSize: 16,
                    // //       fontWeight: FontWeight.bold,
                    // //     ),
                    // //   ),
                    // // ),
                    // SizedBox(height: 5),

                    // addDestinationsButton(),

                    // RaisedButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       _visibleDestinations++;
                    //     });
                    //   },
                    //   color: kPrimaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child:
                    //     // Text(
                    //     //   'Ajouter'.toUpperCase(),
                    //     //   style: TextStyle(
                    //     //     color: Colors.white,
                    //     //     fontSize: 20.0,
                    //     //   ),
                    //     // ),
                    //     IconButton(
                    //       onPressed: () {
                    //       changeSport();
                    //           },
                    //             icon: _sportType,
                    //         color: Colors.black,
                    //             ),

                    //     ),
                    //   ),

                    //MapTextField(),
                    //searchBar(),
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
              //startButton(),
              SizedBox(
                width: 20,
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

  // Widget _addressField({
  //   Icon prefixIcon,
  // }) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.8,
  //     child: TextField(
  //       controller: _controller,
  //       readOnly: true,
  //       onTap: () async {
  //         // generate a new token here
  //         final sessionToken = Uuid().v4();
  //         final Suggestion result = await showSearch(
  //           context: context,
  //           delegate: AddressSearch(sessionToken),
  //         );
  //         // This will change the text displayed in the TextField
  //         if (result != null) {
  //           final placeDetails = await PlaceApiProvider(sessionToken)
  //               .getPlaceDetailFromId(result.placeId);
  //           setState(() {
  //             _controller.text = result.description;
  //             _streetNumber = placeDetails.streetNumber;
  //             _street = placeDetails.street;
  //             _city = placeDetails.city;
  //             _zipCode = placeDetails.zipCode;
  //           });
  //         }
  //       },
  //       decoration: new InputDecoration(
  //         prefixIcon: prefixIcon,
  //         //suffixIcon: Icon(Icons.delete),
  //         labelText: 'Destination',
  //         filled: true,
  //         //fillColor: Colors.white,
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10.0),
  //           ),
  //           borderSide: BorderSide(
  //             color: Colors.grey[400],
  //             width: 2,
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10.0),
  //           ),
  //           borderSide: BorderSide(
  //             color: Colors.grey[400],
  //             width: 2,
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.all(15),
  //         hintText: 'Enter your destination',
  //       ),
  //       // decoration: InputDecoration(
  //       //   icon: Container(
  //       //     margin: EdgeInsets.only(left: 20),
  //       //     width: 10,
  //       //     height: 10,
  //       //     child: Icon(
  //       //       Icons.looks_one,
  //       //       color: Colors.black,
  //       //     ),
  //       //   ),
  //       //   hintText: "Enter your shipping address",
  //       //   border: InputBorder.none,
  //       //   contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
  //       // ),
  //     ),
  //   );
  // }

  void _onModifyItiniraryPressed() {
    setState(() {
      if (itineraryIsVisible == false) {
        itineraryIsVisible = true;
      } else {
        itineraryIsVisible = false;
      }
    });
  }

  // Widget createDestination(nbDestinationsAjoutees) {
  //   var width = MediaQuery.of(context).size.width;

  //   List<Icon> iconDestination = [
  //     Icon(Icons.looks_two),
  //     Icon(Icons.looks_3),
  //     Icon(Icons.looks_4),
  //     Icon(Icons.looks_5),
  //     Icon(Icons.looks_6)
  //   ];

  //   return _textField(
  //       label: 'Destination',
  //       hint: 'Choose destination',
  //       initialValue: '',
  //       prefixIcon: iconDestination[(nbDestinationsAjoutees - 1) % 6],
  //       controller: destinationAddressController,
  //       width: width,
  //       locationCallback: (String value) {
  //         setState(() {
  //           _destinationAddress = value;
  //           //destinations[nbDestinationsAjoutees] = _destinationAddress;
  //         });
  //       });
  // }

  // Widget _textField({
  //   TextEditingController controller,
  //   String label,
  //   String hint,
  //   String initialValue,
  //   double width,
  //   Icon prefixIcon,
  //   Widget suffixIcon,
  //   Function(String) locationCallback,
  // }) {
  //   return Container(
  //     width: width * 0.8,
  //     child: TextField(
  //       onChanged: (value) {
  //         locationCallback(value);
  //         //destinations[1] = value;
  //       },
  //       controller: controller,
  //       //initialValue: initialValue,
  //       decoration: new InputDecoration(
  //         prefixIcon: prefixIcon,
  //         suffixIcon: suffixIcon,
  //         labelText: label,
  //         filled: true,
  //         //fillColor: Colors.white,
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10.0),
  //           ),
  //           borderSide: BorderSide(
  //             color: Colors.grey[400],
  //             width: 2,
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10.0),
  //           ),
  //           borderSide: BorderSide(
  //             color: Colors.grey[400],
  //             width: 2,
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.all(15),
  //         hintText: hint,
  //       ),
  //     ),
  //   );
  // }

  // Widget _textf() {
  //   return Container(

  //     //width: width * 0.8,
  //     child: Row(
  //       children: [
  //         Icon(Icons.looks_one),
  //         searchBar(),
  //       ],
  //     ),
  //   );
  // }
  //

  // void _awaitReturnValueFromSecondScreen(
  //     BuildContext context, String value) async {
  //   // start the SecondScreen and wait for it to finish with a result
  //   final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Search(),
  //       ));

  //   // after the SecondScreen result comes back update the Text widget with it
  //   setState(() {
  //     text = result;
  //   });

  //   value = result;
  // }

  // Widget searchBar() {
  //   return SearchMapPlaceWidget(
  //     hasClearButton: true,
  //     placeType: PlaceType.address,
  //     placeholder: 'Rechercher',
  //     language: "fr",
  //     location: LatLng(45.501690, -73.567253), //montreal
  //     radius: 5000000,
  //     strictBounds: true,
  //     //darkMode: true,
  //     apiKey:
  //         'AIzaSyA8lscKN2eiAjCcBO4xg0AFmySvAMzYfms', //enable Places for Google Maps
  //     onSelected: (Place place) async {
  //       Geolocation geolocation = await place.geolocation;
  //       // mapController
  //       //     .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
  //       // mapController
  //       //     .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
  //       print(geolocation.coordinates);
  //     },
  //   );
  // }

  // Widget addDestinationsButton() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Ink(
  //       decoration: const ShapeDecoration(
  //         color: kPrimaryColor,
  //         shape: CircleBorder(),
  //       ),
  //       child: IconButton(
  //         onPressed: () {
  //           setState(() {
  //             _visibleDestinations++;
  //           });
  //         },
  //         icon: Icon(Icons.add),
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

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
    return RoundedButton(
      text: "Start",
      press: () {
        setState(() {});
      },
    );
    // return Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.all(0.0),
    //     child: Ink(
    //       decoration: const ShapeDecoration(
    //         color: kPrimaryColor,
    //         shape: RoundedRectangleBorder(),
    //       ),
    //       child: IconButton(
    //         onPressed: () {},
    //         splashRadius: 50.0,
    //         iconSize: 40,
    //         icon: Icon(Icons.arrow_right),
    //         color: kPrimaryLightColor,
    //       ),
    //     ),
    //   ),
    // );
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

  Widget recenterButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: const ShapeDecoration(
          color: kPrimaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.location_searching),
          color: Colors.black,
        ),
      ),
    );
  }

  bool setItineraryVisible(bool itineraryIsVisible) {
    if (itineraryIsVisible) {
      return true;
    } else {
      return false;
    }
  }

  bool setVisibleDestination(int _visibleDestinations, int _destinationNumber) {
    if (_visibleDestinations >= _destinationNumber) {
      return true;
    } else {
      return false;
    }
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
