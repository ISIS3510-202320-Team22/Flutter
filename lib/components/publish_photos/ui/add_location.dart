import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() {
    return _AddLocationState();
  }
}

class _AddLocationState extends State<AddLocation> {
  PhotoLocation? _pickedLocation;

  var _isGettingLocation = false;

  String get LocationImage {
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAoh4_qFIhQj5RhFOZ3Hxn9Fc0zNR_8-tQ';
  }

  void _getCurrentLocation() async {
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

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAoh4_qFIhQj5RhFOZ3Hxn9Fc0zNR_8-tQ");

    final response = await http.get(url);

    final resData = json.decode(response.body);

    final address = resData["results"][0]["formatted_address"];

    setState(() {
      _pickedLocation = PhotoLocation(lat, lng, address);
      _isGettingLocation = false;
    });

    //print(_pickedLocation!.address); Addres from your current location
  }

  @override
  Widget build(context) {
    Widget previewContent = Text(
      "No location chosen",
      style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
    );

    //Show the map image from google
    if (_pickedLocation != null) {
      previewContent = Image.network(LocationImage,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          // Where the map location is goign to be displayed
          height: 190,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(100, 192, 192, 192)),
              color: Colors.grey.withOpacity(0.2)),
          child: previewContent,
        ),

        //Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Get current Location"),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Map"),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
