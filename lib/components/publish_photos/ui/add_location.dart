import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';


class AddLocation extends StatefulWidget{

  const AddLocation({super.key});

  @override
  State<AddLocation> createState(){
    return _AddLocationState();
  }
}

  class _AddLocationState extends State<AddLocation>{
  
    Location? _pickedLocation;

    var _isGettingLocation = false;

    void _getCurrentLocation() async{
      
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

      setState(() {
        _isGettingLocation = false;
      });


      print(locationData.latitude);
      print(locationData.altitude);
    }

    @override
    Widget build(context){

      Widget previewContent = Text(
              "No location chosen",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
            );

      if (_isGettingLocation){
        previewContent = const CircularProgressIndicator();
      }

      return Column(children: [
        
        Container( // Where the map location is goign to be displayed
            height: 190,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(100, 192, 192, 192)),
              color: Colors.grey.withOpacity(0.2)
            ),
            child: previewContent,
        ),

        //Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text("Get current Location"),
            onPressed: () {
              _getCurrentLocation;
            },
          ),

           TextButton.icon(
            icon: const Icon(Icons.map),
            label: const Text("Map"),
            onPressed: () {},
          )

        ],
        )
      ],);
    }
  }
