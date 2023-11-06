import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guarap/components/publish_photos/ui/nearby.dart';

class NearbyLocationApi {
  static NearbyLocationApi? _instance;

  NearbyLocationApi._();

  static NearbyLocationApi get instance {
    if (_instance == null) {
      _instance = NearbyLocationApi._();
    }
    return _instance!;
  }

  Future<List<Nearby>> getNearby(
      LatLng userLocation, double radius, String type, String keyword) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation.latitude},${userLocation.longitude}&radius=$radius&type=$type&keyword=$keyword&key=AIzaSyBAcv6XqWc38LqaLlM4DQionlYVTS3SYMA');

    http.Response response = await http.get(url);
    final values = json.decode(response.body);
    final List result = values['results'];
    print(result);
    return result.map((e) => Nearby.fromJson(e)).toList();
  }
}
