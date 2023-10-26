import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PhotoLocation {
  const PhotoLocation(this.latitude, this.longitude, this.address);

  final double latitude;
  final double longitude;
  final String address;
}

class LocationModel {
  LocationModel(this.title, this.image, this.location) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PhotoLocation location;
}
