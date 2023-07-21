import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seventh_app/model/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:seventh_app/screen/map.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});

  final void Function(PlaceLocation location) onSelectedLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  String get locationImage{
    if(_pickedLocation == null){
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyArjMdTj7R9J9skpz_931HKO71R38LRAIw';
  }

  Future<void> _savePlace(double lat, double lon) async {
final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=AIzaSyArjMdTj7R9J9skpz_931HKO71R38LRAIw');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    print(resData);
    final address = resData['results'][0]['formatted_address'];

    setState((){
      _pickedLocation = PlaceLocation(latitude: lat, longitude: lon, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectedLocation(_pickedLocation!);
  }
  void _getCurrentLoacation() async {

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState((){
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lon = locationData.longitude;
    if(lat == null && lon == null){
      return;
    }
    _savePlace(lat!, lon!);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx) => const MapScreen(),));

    if(pickedLocation == null){
      return;
    }

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text('No location chosen',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ));
    if(_isGettingLocation){
      previewContent = const CircularProgressIndicator();
    }

    if(_pickedLocation != null){
      previewContent = Image.network(locationImage, fit: BoxFit.cover , width: double.infinity, height: double.infinity);
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLoacation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: _selectOnMap,
            )
          ],
        ),
      ],
    );
  }
}
