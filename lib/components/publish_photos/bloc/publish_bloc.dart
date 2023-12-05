import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:guarap/components/publish_photos/repository/nearby_location_api.dart';
import 'package:guarap/components/publish_photos/repository/posts_repository.dart';
import 'package:guarap/components/publish_photos/repository/storage_methods.dart';
import 'package:guarap/components/publish_photos/ui/nearby.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';
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
    on<CategorySelectedEvent>(categorySelectedEvent);
    on<NearbyLocationsEvent>(nearbyLocationsEvent);
    on<ChangeSwitchAddEvent>(changeSwitchAddEvent);
    on<AddInputMoneyEvent>(addInputMoneyEvent);
    on<AddPhotoButtonClickedSponsorEvent>(addPhotoButtonClickedSponsorEvent);
    on<SendSponsorDataEvent>(sendSponsorDataEvent);
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
    String internetConnection =
        await PostRepository().checkInternetConnection();
    if (internetConnection != "success") {
      emit(NoInternetErrorActionState());
      emit(PublishInitial());
      return;
    }
    // Url is a list with two elements, the first one is the status of the upload
    // and the second one is the url of the image (or the error message)
    final List<String> url = await StorageMethods()
        .uploadImageToStorage('images/', File(event.image!.path), true);
    if (url[0] == 'failed') {
      emit(PublishPhotoErrorState(errorMessage: url[1]));
      emit(PublishInitial());
      return;
    } else {
      final res = await PostRepository().publishPost(event.date,
          event.description, event.category, url[1], event.location, 0);
      if (res == "success") {
        emit(PublishSuccessState());
      } else {
        emit(PublishErrorState(errorMessage: res));
        emit(PublishInitial());
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

    // final address = resData["results"][0]["formatted_address"];
    final address = resData["results"][0]["address_components"][2]["long_name"];
    final address2 =
        resData["results"][0]["address_components"][4]["long_name"];
    emit(LocationSettedState(
        location: PhotoLocation(lat, lng, address + ", " + address2)));
  }

  FutureOr<void> mapLocationEvent(
      MapLocationEvent event, Emitter<PublishState> emit) async {
    final pickedLocation = await Navigator.of(event.context).push<LatLng>(
        MaterialPageRoute(
            builder: (ctx) => MapScreen(publishBloc: event.publishBloc)));

    if (pickedLocation == null) {
      return;
    }

    var lat = pickedLocation.latitude;
    var lng = pickedLocation.longitude;

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAoh4_qFIhQj5RhFOZ3Hxn9Fc0zNR_8-tQ");

    final response = await http.get(url);

    final resData = json.decode(response.body);

    // final address = resData["results"][0]["formatted_address"];

    final address = resData["results"][0]["address_components"][2]["long_name"];
    final address2 =
        resData["results"][0]["address_components"][4]["long_name"];

    print(address);
    print(address2);
    print(resData);

    emit(LocationSettedState(
        location: PhotoLocation(lat, lng, address + ", " + address2)));
  }

  FutureOr<void> goToFeedEvent(
      GoToFeedEvent event, Emitter<PublishState> emit) {
    emit(GoToFeedActionState());
  }

  FutureOr<void> categorySelectedEvent(
      CategorySelectedEvent event, Emitter<PublishState> emit) {
    emit(CategorySelectedState(category: event.category));
  }

  FutureOr<void> nearbyLocationsEvent(
      NearbyLocationsEvent event, Emitter<PublishState> emit) async {
    final List<Nearby> result = await NearbyLocationApi.instance
        .getNearby(event.currentLocation, 300, "restaurant", "");
    emit(NearbyPlacesState(nearby: result));
  }

  FutureOr<void> changeSwitchAddEvent(
      ChangeSwitchAddEvent event, Emitter<PublishState> emit) {
    emit(ChangeSwitchAddState(switched: event.switched));
  }

  FutureOr<void> addInputMoneyEvent(
      AddInputMoneyEvent event, Emitter<PublishState> emit) {
    emit(AddInputMoneyState(inputMoney: event.moneyWidget));
  }

  FutureOr<void> addPhotoButtonClickedSponsorEvent(
      AddPhotoButtonClickedSponsorEvent event,
      Emitter<PublishState> emit) async {
    print("hola");
    final pickedImageSponsor = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: double.infinity,
        maxWidth: double.infinity);

    emit(AddToCircleSponsorPhotoState(
        pickedImageSponsor: File(pickedImageSponsor!.path)));
  }

  FutureOr<void> sendSponsorDataEvent(
      SendSponsorDataEvent event, Emitter<PublishState> emit) async {
    String internetConnection =
        await PostRepository().checkInternetConnection();
    if (internetConnection != "success") {
      emit(NoInternetErrorActionState());
      emit(PublishInitial());
      return;
    }
    // Url is a list with two elements, the first one is the status of the upload
    // and the second one is the url of the image (or the error message)
    final List<String> url = await StorageMethods()
        .uploadImageToStorage('images/', File(event.sponsorImage!.path), true);
    if (url[0] == 'failed') {
      emit(PublishPhotoErrorState(errorMessage: url[1]));
      emit(PublishInitial());
      return;
    } else {
      final res = await PostRepository().publishPost(
        Timestamp.now(),
        event.sponsorDescription,
        "Promociones",
        url[1],
        "",
        event.sponsorMoney ~/ 4,
      );
      if (res == "success") {
        emit(PublishSuccessState());
        Navigator.pop(event.context);
      } else {
        emit(PublishErrorState(errorMessage: res));
        emit(PublishInitial());
      }
    }
  }
}
