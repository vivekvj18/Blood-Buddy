import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/blocs/application_bloc.dart';
import 'package:bloodbuddyfinal/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum Location { gate, canteen, micmac, mechc, oat, audi, acaddept }

class StationDetails extends StatefulWidget {
  static String routeName = '/home-screen';
  Marker destination;
  Marker origin;
  StationDetails({required this.destination, required this.origin, Key? key})
      : super(key: key);

  @override
  _StationDetailsState createState() => _StationDetailsState();
}

class _StationDetailsState extends State<StationDetails> {
  late Marker destination;
  late Marker origin;
  late String placeType = 'restaurant';
  List<Marker> dtuMarkers = [];

  @override
  void initState() {
    destination = widget.destination;
    origin = widget.origin;
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Marker manualMarker(LatLng latLng, String title) {
    return Marker(
      markerId: MarkerId(title),
      position: latLng,
      onTap: () {},
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

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: const FaIcon(
          //     FontAwesomeIcons.heart,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {},
          // ),
        ],
        title: const Text(
          "Navigation",
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/jagah.png',
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text("Local Admin Name",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Text(
              '${(Geolocator.distanceBetween(origin.position.latitude, origin.position.longitude, destination.position.latitude, destination.position.longitude) / 1000).toStringAsFixed(2)}KM Away from you',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text("Subtitle",
              style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(58, 0, 64, 20),
            child: Align(
              alignment: Alignment.center,
              child: Text("Contact number: 12345678",
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
              onPressed: () async {
                int polylineCount = 0;
                Set<Polyline> polylines = {};
                final String polyLineIdVal = 'polyline_id_$polylineCount';
                var directions = await getDirections(origin, destination);
                print("printin directions polyline_decoded");
                print(directions['polyline_decoded']);
                polylineCount++;
                List<PointLatLng> points = directions['polyline_decoded'];
                polylines.add(
                  Polyline(
                    polylineId: PolylineId(polyLineIdVal),
                    color: Color.fromARGB(255, 0, 207, 131),
                    points: points
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                    width: 3,
                  ),
                );
                print("added");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(
                      origin: origin,
                      destination: destination,
                      polylines: polylines,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(
                  "Take Me there!",
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
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
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

void snackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('No response from server!'),
    ),
  );
}
