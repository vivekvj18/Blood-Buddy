import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/blocs/application_bloc.dart';
import 'package:bloodbuddyfinal/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:bloodbuddyfinal/utils/mapStyle.dart';

enum Location { gate, canteen, micmac, mechc, oat, audi, acaddept }

class NavigationScreen extends StatefulWidget {
  static String routeName = '/navigation-screen';
  Marker destination;
  Marker origin;
  Set<Polyline> polylines = {};
  NavigationScreen({required this.destination, required this.origin, required this.polylines, Key? key})
      : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Marker> dtuMarkers = [];
  late Marker origin;
  late Marker destination;
  late Set<Polyline> polylines;
  Set<Polyline> _polyLines = Set<Polyline>();
  Polyline rasta = Polyline(
    polylineId: PolylineId('rasta'),
    color: Colors.red,
    width: 3,
    points: [],
  );
  int polylineCount = 0;
  var directions;
  @override
  void initState() {
    // "a");
    origin = widget.origin;
    destination = widget.destination;
    dtuMarkers.add(destination);
    polylines = widget.polylines;
    //doThis();
    super.initState();
  }

  Future<void> doThis() async {
    print("do this");
    directions = await getDirections(origin, destination);
    print("printin directions polyline_decoded");
    print(directions['polyline_decoded']);
    _setPolylines(directions['polyline_decoded']);
  }

  Future<Map<String, dynamic>> getDirections(
      Marker origin, Marker destination) async {
    String key = 'AIzaSyC_ULZ8l6eM1SaOXbEJsm04bbu3Xcsz0FQ';
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.position.latitude},${origin.position.longitude}&destination=${destination.position.latitude},${destination.position.longitude}&key=$key';
    print("making request");
    var response = await http.get(Uri.parse(url));
    //print(response.body);
    var json = convert.jsonDecode(response.body);
    //print(json);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
    //print(results['polyline_decoded']);
    return results;
  }

  void _setPolylines(List<PointLatLng> points) {
    final String polyLineIdVal = 'polyline_id_$polylineCount';
    polylineCount++;
    _polyLines.add(
      Polyline(
        polylineId: PolylineId(polyLineIdVal),
        color: Color.fromARGB(255, 0, 207, 131),
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
        width: 3,
      ),
    );
    print("added");
  }

  @override
  void dispose() {
    super.dispose();
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
      body: Stack(
        children: [
          (applicationBloc.currentLocation == null)
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 255, 162),
                ))
              : Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: GoogleMap(
                    mapToolbarEnabled: true,
                    buildingsEnabled: true,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller) async {
                      controller.setMapStyle(MapStyle.mapStyle);
                      print("map created");
                      updateCameraLocation(
                          origin.position, destination.position, controller);
                    },
                    polylines: polylines,
                    initialCameraPosition: CameraPosition(
                      target: origin.position,
                      zoom: 16,
                      tilt: 80,
                      bearing: 30,
                    ),
                    markers: Set<Marker>.of(dtuMarkers),
                  ),
                ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(236, 255, 255, 255),
                      const Color.fromARGB(92, 255, 255, 255)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(236, 255, 255, 255),
                      const Color.fromARGB(92, 255, 255, 255)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
