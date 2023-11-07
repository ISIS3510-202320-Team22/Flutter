import 'package:flutter/material.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guarap/components/publish_photos/ui/nearby.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location =
          const PhotoLocation(4.600235319708498, -74.06734968029151, ""),
      this.isSelectedLocation = true,
      required this.publishBloc});

  final PhotoLocation location;
  final bool isSelectedLocation;
  final PublishBloc publishBloc;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(4.600235319708498, -74.06734968029151);
  List<Nearby> nearbyLocations = <Nearby>[];

  @override
  Widget build(context) {
    return BlocConsumer<PublishBloc, PublishState>(
        bloc: widget.publishBloc,
        listenWhen: (previous, current) => current is PublishActionState,
        buildWhen: (previous, current) => current is! PublishActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case NearbyPlacesState:
              final nearbyPlacesState = state as NearbyPlacesState;
              nearbyLocations = nearbyPlacesState.nearby;
              break;
          }

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
            body: Stack(children: <Widget>[
              GoogleMap(
                onTap: !widget.isSelectedLocation
                    ? null
                    : (position) {
                        setState(() {
                          _pickedLocation = position;
                        });
                      },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        widget.location.latitude, widget.location.longitude),
                    zoom: 16),
                markers: (_pickedLocation == null && widget.isSelectedLocation)
                    ? {}
                    : {
                        Marker(
                            markerId: const MarkerId('m1'),
                            position: _pickedLocation != null
                                ? _pickedLocation!
                                : LatLng(widget.location.latitude,
                                    widget.location.longitude),
                            onTap: () async {
                              widget.publishBloc.add(NearbyLocationsEvent(
                                currentLocation: _pickedLocation,
                              ));
                            }),
                      },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nearbyLocations.length,
                        itemBuilder: (_, index) => Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: SizedBox(
                              width: 200,
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    nearbyLocations[index]
                                                        .icon!),
                                                fit: BoxFit.cover)),
                                      )),
                                      Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    nearbyLocations[index]
                                                        .name!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '${nearbyLocations[index].rating?.toString() ?? 0}' +
                                                              ' '),
                                                      const Icon(
                                                        Icons.star,
                                                        size: 16,
                                                      )
                                                    ],
                                                  ),
                                                  Text(nearbyLocations[index]
                                                              .userRatingsTotal !=
                                                          null
                                                      ? ' ${nearbyLocations[index].userRatingsTotal}' +
                                                          ' reviews'
                                                      : '0 reviews'),
                                                ],
                                              )))
                                    ]),
                              ),
                            )))),
              ),
            ]),
          );
        });
  }
}
