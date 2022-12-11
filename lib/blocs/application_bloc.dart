import 'dart:async';
import 'dart:developer';
import 'package:bloodbuddyfinal/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloodbuddyfinal/models/place_item.dart';
import 'package:bloodbuddyfinal/models/place_search.dart';
import 'package:bloodbuddyfinal/services/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();

  //Variables
  Position? currentLocation;
  late List<PlaceSearch> searchResults;
  late StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  late String placeType;
  late String placeSelected;
  late User auth;
  late List<Placeitem> placeResults;
  List<Marker> markers = [];
  List<Marker> dtuMarkers = [];
  late List<Placeitem> restaurantsInfo;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
    log("[log] currentLocation: $currentLocation");
    //get auth
    if (currentLocation != null && auth.uid != null) {
      //post user location
      postDetailsToFirestore(auth, currentLocation!);
    }
  }

  postDetailsToFirestore(User user, Position position) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = position.latitude.toString();
    userModel.uid = user.uid;
    userModel.firstName = position.longitude.toString();
    userModel.displayName = user.displayName.toString();
    userModel.createdAt = DateTime.now().toString();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) => log("[log] user details posted to firestore"));
  }
}
