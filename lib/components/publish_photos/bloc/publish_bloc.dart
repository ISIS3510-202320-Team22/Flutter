import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:guarap/components/publish_photos/repository/posts_repository.dart';
import 'package:guarap/components/publish_photos/repository/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guarap/components/publish_photos/ui/map.dart';
part 'publish_event.dart';
part 'publish_state.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  PublishBloc() : super(PublishInitial()) {
    on<AddPhotoButtonClickedEvent>(addPhotoButtonClickedEvent);
    on<PublishPostEvent>(publishPostEvent);
    on<AddLocationEvent>(addLocationEvent);
    on<MapLocationEvent>(mapLocationEvent);
    on<GoToFeedEvent>(goToFeedEvent);
  }

  FutureOr<void> addPhotoButtonClickedEvent(
      AddPhotoButtonClickedEvent event, Emitter<PublishState> emit) async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: double.infinity,
        maxWidth: double.infinity);

    emit(AddToCirclePhotoState(pickedImage: File(pickedImage!.path)));
  }

  FutureOr<void> publishPostEvent(
      PublishPostEvent event, Emitter<PublishState> emit) async {
    emit(PublishingPostState());
    final url = await StorageMethods()
        .uploadImageToStorage('images/', File(event.image!.path), true);
    if (url == 'failed') {
      emit(PublishPhotoErrorState());
      return;
    } else {
      final send = await PostRepository().publishPost(
        event.date,
        event.description,
        event.category,
        url,
        event.location,
      );
      if (send) {
        emit(PublishSuccessState());
      } else {
        emit(PublishErrorState());
      }
    }
  }

  FutureOr<void> addLocationEvent(
      AddLocationEvent event, Emitter<PublishState> emit) async {
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

    emit(LoadingCircleState());
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

    emit(LocationSettedState(location: PhotoLocation(lat, lng, address)));
  }

  FutureOr<void> mapLocationEvent(
      MapLocationEvent event, Emitter<PublishState> emit) async {
    final pickedLocation = await Navigator.of(event.context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) => const MapScreen()));

    if (pickedLocation == null) {
      return;
    }

    var lat = pickedLocation.latitude;
    var lng = pickedLocation.longitude;

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAoh4_qFIhQj5RhFOZ3Hxn9Fc0zNR_8-tQ");

    final response = await http.get(url);

    final resData = json.decode(response.body);

    final address = resData["results"][0]["formatted_address"];

    emit(LocationSettedState(location: PhotoLocation(lat, lng, address)));
  }

  FutureOr<void> goToFeedEvent(
      GoToFeedEvent event, Emitter<PublishState> emit) {
    emit(GoToFeedActionState());
  }
}
