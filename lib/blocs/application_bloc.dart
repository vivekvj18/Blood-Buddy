import 'dart:async';
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
  late User auth;
  late List<PlaceSearch> searchResults;
  late StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  late String placeType;
  late String placeSelected;
  late List<Placeitem> placeResults;
  List<Marker> markers = [];
  List<Marker> dtuMarkers = [];
  late List<Placeitem> restaurantsInfo;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    await geoLocatorService.getCurrentLocation().then((value) async {
      currentLocation = value;
      notifyListeners();
      FirebaseAuth.instance;
      if(currentLocation!=null&& auth.uid!=null){
         FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = currentLocation!.latitude.toString();
    userModel.uid = user.uid;
    userModel.firstName = currentLocation!.longitude.toString();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
        notifyListeners();
      }
      //auth; insert auth transfer function
      //post details to firebase

      notifyListeners();
    });

    notifyListeners();
  }
}
