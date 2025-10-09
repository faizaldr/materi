import 'dart:async';

import 'package:location/location.dart';

class LatLon {
  double? latitude;
  double? longitude;
  LatLon(this.latitude, this.longitude);
}

class LocationService {
  Location location = Location();
  StreamController<LatLon> _locationController = StreamController<LatLon>();
  Stream<LatLon> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((LocationData locationData) {
          if (locationData != null) {
            _locationController.add(
              LatLon(locationData.latitude, locationData.longitude),
            );
            print(locationData);
          }
        });
      }
    });
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}
