import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  StreamController<LocationData> _locationController =
      StreamController<LocationData>();
  Stream<LocationData> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((LocationData locationData) {
          if (locationData != null) {
            _locationController.add(locationData);
            print(locationData);
          }
        });
      }
    });
  }
}
