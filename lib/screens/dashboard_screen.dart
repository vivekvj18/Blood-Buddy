import 'dart:developer';

import 'package:bloodbuddyfinal/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bloodbuddyfinal/blocs/application_bloc.dart';
import 'package:bloodbuddyfinal/models/markers_model.dart';
import 'dart:async';
import 'package:bloodbuddyfinal/screens/sidebar_screen.dart';
import 'package:bloodbuddyfinal/screens/station_details_page.dart';
import 'package:bloodbuddyfinal/utils/mapStyle.dart';

class DashBoardScreen extends StatefulWidget {
  late User auth;
  DashBoardScreen({Key? key, User? auth}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Marker> dtuMarkers = [];
  AutoGenerate markers = AutoGenerate(markers: []);
  late Marker closest;
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  LatLng destination = const LatLng(0, 0);
  bool functioncalled = true;
  bool firstTimeCamera = false;
  late Marker currentMarker;
  late Marker destinationMarker;
  late BitmapDescriptor customIcon;
  late GoogleMapController mapController;
  late FirebaseAuth auth;

  @override
  void initState() {
    if (functioncalled) {
      // setState(() {
      //   functioncalled = false;
      // });
      setState(() {
        final applicationBloc =
            Provider.of<ApplicationBloc>(context, listen: false);
        //applicationBloc.auth = widget.auth;
      });
      customMarker();
      getMarkerData();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSearch(String search) {
    print("");
  }

  void setPolylines() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        // LatLng(
        //                       applicationBloc.currentLocation!.latitude,
        //                       applicationBloc.currentLocation!.longitude),
        'AIzaSyAYCKe8wkUyWtgAhNhBQku9Rn8zsVoAWXg',
        PointLatLng(applicationBloc.currentLocation!.latitude,
            applicationBloc.currentLocation!.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    // "api called");
    // result.errorMessage);
    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() => _polylines.add(Polyline(
            polylineId: const PolylineId('poly'),
            color: Colors.red,
            points: polylineCoordinates,
            width: 3,
          )));
    }
  }

  getMarkerData() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    // "news line");
    final response = await FirebaseFirestore.instance.collection('users').get();
    //markers = AutoGenerate.fromJson(response.docs[0].data());
    List<UserModel> data = [];
    for (int i = 0; i < response.docs.length; i++) {
      data.add(UserModel.fromMap(response.docs[i].data()));
    }

    log("[data fetched and put into the model] ${data.length}");

    setState(() {
      LatLng co = LatLng(28.70448061865909, 77.25660755168144);
      dtuMarkers.add(manualMarker(co, 'BHAJANPURA'));
      for (int i = 0; i < data.length; i++) {
        dtuMarkers.add(manualMarker(
            LatLng(
                double.parse(data[i].email!), double.parse(data[i].firstName!)),
            data[i].displayName!));
      }
      if (applicationBloc.currentLocation != null) {
        dtuMarkers.sort((a, b) => Geolocator.distanceBetween(
                a.position.latitude,
                a.position.longitude,
                applicationBloc.currentLocation!.latitude,
                applicationBloc.currentLocation!.longitude)
            .compareTo(Geolocator.distanceBetween(
                b.position.latitude,
                b.position.longitude,
                applicationBloc.currentLocation!.latitude,
                applicationBloc.currentLocation!.longitude)));
      }
      dtuMarkers.removeAt(0);
      closest = dtuMarkers[0];
      log("[markers added] ${dtuMarkers.length}");
    });
  }

  void customMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 0.1, size: Size(1, 1)),
            'assets/icons/location.png')
        .then((value) => {customIcon = value});
  }

  Marker manualMarker(LatLng latLng, String title) {
    return Marker(
      markerId: MarkerId(title),
      position: latLng,
      //icon: customIcon,
      onTap: () {
        final applicationBloc =
            Provider.of<ApplicationBloc>(context, listen: false);
        setState(() {
          destinationMarker = Marker(
            markerId: MarkerId(title),  
            position: latLng,
            //icon: customIcon,
          );
          if (applicationBloc.currentLocation != 0) {
            BitmapDescriptor.fromAssetImage(
                    const ImageConfiguration(
                        devicePixelRatio: 0.1, size: Size(1, 1)),
                    'assets/icons/location.png')
                .then((value) => {customIcon = value});
            setState(() {
              currentMarker = Marker(
                markerId: const MarkerId("current"),
                position: LatLng(applicationBloc.currentLocation!.latitude,
                    applicationBloc.currentLocation!.longitude),
                infoWindow: const InfoWindow(
                  title: "Current Location",
                  snippet: "Your current location",
                ),
              );
            });
          }
        });
        destination = latLng;
        setPolylines();
        double mWidth = MediaQuery.of(context).size.width;
        double mHeight = MediaQuery.of(context).size.height;
        // "got till here");
        // "proceeded");
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          builder: (builder) {
            return SizedBox(
              width: mWidth,
              height: mHeight * 0.25,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('$title',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Text(
                      "${(Geolocator.distanceBetween(applicationBloc.currentLocation!.latitude, applicationBloc.currentLocation!.longitude, destination.latitude, destination.longitude) / 1000).toStringAsFixed(2)} KM Away from you",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 5,
                        minimumSize: const Size(167, 50),
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationDetails(
                                origin: currentMarker,
                                destination: destinationMarker),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Check Availability",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      infoWindow: InfoWindow(
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      //extendBodyBehindAppBar: true,
      drawer: const NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Navigate",
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Autocomplete<Marker>(
                    displayStringForOption: (Marker option) {
                      return option.markerId.value;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditing) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditing,
                        onChanged: (value) => onSearch(value),
                        onTap: () {
                          print("show list");
                        },
                        style: TextStyle(
                          decorationColor: Colors.black,
                          color: Colors.black,
                        ),
                        //controller: _passwordController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          labelText: "Search",
                        ),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment(-0.25, -1),
                        child: Material(
                          elevation: 4,
                          child: Container(
                            height: 110.00 * options.length,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        options.toList()[0].markerId.value),
                                    subtitle: Text(
                                        "${(Geolocator.distanceBetween(applicationBloc.currentLocation!.latitude, applicationBloc.currentLocation!.longitude, options.toList()[index].position.latitude, options.toList()[index].position.longitude) / 1000).toStringAsFixed(2)} KM Away from you"),
                                    onTap: () {
                                      options.toList()[index].onTap!();
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: options.length),
                          ),
                        ),
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      dtuMarkers.sort((a, b) => Geolocator.distanceBetween(
                              a.position.latitude,
                              a.position.longitude,
                              applicationBloc.currentLocation!.latitude,
                              applicationBloc.currentLocation!.longitude)
                          .compareTo(Geolocator.distanceBetween(
                              b.position.latitude,
                              b.position.longitude,
                              applicationBloc.currentLocation!.latitude,
                              applicationBloc.currentLocation!.longitude)));
                      if (textEditingValue.text == '') {
                        return Iterable<Marker>.empty();
                      }
                      return dtuMarkers.toSet().toList().where((Marker option) {
                        return option.markerId.value.contains(
                            RegExp(textEditingValue.text, caseSensitive: false),
                            0);
                      });
                      //               dtuMarkers.sort((a, b) => Geolocator.distanceBetween(
                      //     a.position.latitude,
                      //     a.position.longitude,
                      //     applicationBloc.currentLocation!.latitude,
                      //     applicationBloc.currentLocation!.longitude)
                      // .compareTo(Geolocator.distanceBetween(
                      //     b.position.latitude,
                      //     b.position.longitude,
                      //     applicationBloc.currentLocation!.latitude,
                      //     applicationBloc.currentLocation!.longitude)));
                    },
                    onSelected: (Marker selection) {
                      selection.onTap!();
                      debugPrint('You just selected $selection');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: (applicationBloc.currentLocation == null)
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 0, 255, 162),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (dtuMarkers.toSet().length == null)
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 0, 255, 162),
                          ))
                        : GoogleMap(
                            mapType: MapType.normal,
                            trafficEnabled: false,
                            myLocationEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              controller.setMapStyle(MapStyle.mapStyle);
                              setState(() {
                                mapController = controller;
                              });
                              // "map crated");
                              if (firstTimeCamera) {
                                getMarkerData().then(
                                    // "got marker data"),
                                    updateCameraLocation(
                                        LatLng(
                                            applicationBloc
                                                .currentLocation!.latitude,
                                            applicationBloc
                                                .currentLocation!.longitude),
                                        Set<Marker>.of(dtuMarkers)
                                            .first
                                            .position,
                                        controller));
                                setState(() {
                                  firstTimeCamera = false;
                                });
                              }
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  applicationBloc.currentLocation!.latitude,
                                  applicationBloc.currentLocation!.longitude),
                              zoom: 16,
                              tilt: 65,
                              bearing: 30,
                            ),
                            markers: Set<Marker>.of(dtuMarkers),
                            compassEnabled: false,
                            tiltGesturesEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: true,
                            zoomGesturesEnabled: true,
                            rotateGesturesEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomControlsEnabled: false,
                          ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 5,
                minimumSize: const Size(167, 50),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                primary: Colors.black,
              ),
              onPressed: () {
                // "button pressedaaaa");
                setState(() {
                  firstTimeCamera = true;
                });
                updateCameraLocation(
                    LatLng(applicationBloc.currentLocation!.latitude,
                        applicationBloc.currentLocation!.longitude),
                    dtuMarkers.first.position,
                    mapController);
                
              },
              child: Center(
                child: Text(
                  "Find Nearest Local Admin",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  void snackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No response from server!'),
      ),
    );
  }
}
