import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';


class AddLocation extends StatefulWidget{

  AddLocation({super.key});

  @override
  State<AddLocation> createState(){
    return _AddLocationState();
  }
}

  class _AddLocationState extends State<AddLocation>{

    void _getCurrentLocation() async{

      Location location = new Location();

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

      locationData = await location.getLocation();
    }

    @override
    Widget build(context){
      return Column(children: [
        
        Container( // Where the map location is goign to be displayed
            height: 190,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(100, 192, 192, 192)),
              color: Colors.grey.withOpacity(0.2)
            ),
            child: Text(
              "No location chosen",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
            ), 
        ),

        //Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text("Add Location"),
            onPressed: () {},
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
