import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation extends ChangeNotifier {
  Position? getPosition;
  String? address;
  String? latitude;
  String? longitude;
  String? accuracy;

  String? get currentPositionLatitude {
    return latitude;
  }

  String? get currentPositionLongitude {
    return longitude;
  }

  String? get currentPositionAccuracy {
    return accuracy;
  }

  Position? get currentPosition {
    return getPosition;
  }

  String? get currentAddress {
    return address;
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep your location on');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied forever');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemark[0];

      getPosition = position;
      latitude = getPosition!.latitude.toStringAsFixed(5);
      longitude = getPosition!.longitude.toStringAsFixed(5);
      accuracy = getPosition!.latitude.toStringAsFixed(5);
      address =
          " ${place.street}, ${place.postalCode}, ${place.locality}, ${place.country}";
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return null;
  }
}
