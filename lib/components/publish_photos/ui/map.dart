import 'package:flutter/material.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location =
          const PhotoLocation(4.600235319708498, -74.06734968029151, ""),
      this.isSelectedLocation = true});

  final PhotoLocation location;
  final bool isSelectedLocation;

  @override
  State<MapScreen> createState() {
    return _MapScrenState();
  }
}

class _MapScrenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isSelectedLocation
              ? "Pick your location"
              : "Your location"),
          actions: [
            if (widget.isSelectedLocation)
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(_pickedLocation); // pass info to the past view
                },
                icon: const Icon(Icons.save),
              )
          ],
        ),
        body: GoogleMap(
          onTap: !widget.isSelectedLocation
              ? null
              : (position) {
                  setState(() {
                    _pickedLocation = position;
                  });
                },
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.location.latitude, widget.location.longitude),
              zoom: 16),
          markers: (_pickedLocation == null && widget.isSelectedLocation)
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId('m1'),
                      position: _pickedLocation != null
                          ? _pickedLocation!
                          : LatLng(widget.location.latitude,
                              widget.location.longitude))
                },
        ));
  }
}
