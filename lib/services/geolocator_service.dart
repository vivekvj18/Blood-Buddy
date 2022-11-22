import 'package:bloodbuddyfinal/models/markers_model.dart';
import 'package:bloodbuddyfinal/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    print('done');
    // late Markers userdata=Markers(no: 1, region: 'region', address: 'address', auxaddres: 'auxaddres');
    // userdata.latitude= await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high) as String;
    // postDetailsToFirestore(userdata);
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  postDetailsToFirestore(Markers userdata) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   // User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    Map<String, dynamic> data={};
    data['latitude']=userdata.latitude;
    data['longitude']=userdata.longitude;
    data['address']=userdata.address;
    data['auxaddres']=userdata.auxaddres;
  
  
  
    await firebaseFirestore
        .collection("markers")
        .doc("VtAi50qtn4moqG647IS2").collection("markers").add(data);
        //.set(userModel.toMap());
    //Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

}

