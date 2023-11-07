import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key, required this.publishBloc});

  final PublishBloc publishBloc;

  get latlng => null;

  @override
  State<AddLocation> createState() {
    return _AddLocationState();
  }
}

class _AddLocationState extends State<AddLocation> {
  PhotoLocation? _pickedLocation;

  String get LocationImage {
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAoh4_qFIhQj5RhFOZ3Hxn9Fc0zNR_8-tQ';
  }

  LatLng get latlng {
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return LatLng(lat, lng);
  }

  @override
  Widget build(context) {
    Widget previewContent = Text(
      "No location chosen",
      style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
    );

    return BlocConsumer<PublishBloc, PublishState>(
      bloc: widget.publishBloc,
      listenWhen: (previous, current) => current is PublishActionState,
      buildWhen: (previous, current) => current is! PublishActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        //PublishBloc(context: context);
        switch (state.runtimeType) {
          case LoadingCircleState:
            previewContent = const CircularProgressIndicator();
            break;
          case LocationSettedState:
            final locationSettedState = state as LocationSettedState;
            _pickedLocation = locationSettedState.location;
            //Show the map image from google
            if (_pickedLocation != null) {
              previewContent = Image.network(LocationImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity);
            }
            break;
        }
        return Column(
          children: [
            Container(
              // Where the map location is goign to be displayed
              height: 190,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(100, 192, 192, 192)),
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
                  onPressed: () {
                    widget.publishBloc.add(AddLocationEvent());
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text("Map"),
                  onPressed: () {
                    widget.publishBloc
                        .add(MapLocationEvent(context, widget.publishBloc));
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
}
