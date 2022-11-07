import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/blocs/application_bloc.dart';
import 'package:bloodbuddyfinal/main.dart';
import 'package:bloodbuddyfinal/models/markers_model.dart';
import 'package:bloodbuddyfinal/screens/dashboard_screen.dart';
import 'package:bloodbuddyfinal/screens/notifications_screen.dart';
import 'package:bloodbuddyfinal/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    DashBoardScreen(),
    NotificationsScreen(),
    const SettingsScreen(),
  ];
  int _selectedIndex = 0;
  List<Marker> dtuMarkers = [];
  AutoGenerate markers = AutoGenerate(markers: []);
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  LatLng destination = const LatLng(0, 0);
  
  Uri insta = Uri.parse('http://www.bloodbuddyfinal.in/');
  Uri twt = Uri.parse('https://twitter.com/go_selectric');
  Uri fb = Uri.parse('https://m.facebook.com/bloodbuddyfinal.official');
  Uri lin = Uri.parse('https://www.linkedin.com/company/bloodbuddyfinal/');
  Uri discord = Uri.parse('https://discord.com/invite/hmGaGdUkcT');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.data);
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          print(notification.body);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                importance: Importance.high,
                priority: Priority.high,
                color: Colors.green,
                channelShowBadge: true,
                visibility: NotificationVisibility.public,
                playSound: true,
                icon: 'assets/logo.png',
                channelDescription: 'Channel Description',
              ),
            ),
          );
        }
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp message was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.91787439613,
                          height: MediaQuery.of(context).size.height *
                              0.69977678571,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(238, 255, 255, 255),
                                Color.fromARGB(92, 255, 255, 255)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  notification.title.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        notification.body.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Join us to be a part of our amazing community #bloodbuddyfinal_Squad Along with knowledge of the EV market, you will get to work with a startup in the future.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(insta),
                                            icon: const Icon(
                                                FontAwesomeIcons.instagram),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(fb),
                                            icon:
                                                const Icon(FontAwesomeIcons.facebook),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(twt),
                                            icon:
                                                const Icon(FontAwesomeIcons.twitter),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () =>
                                                _launchUrl(discord),
                                            icon:
                                                const Icon(FontAwesomeIcons.discord),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(lin),
                                            icon:
                                                const Icon(FontAwesomeIcons.linkedin),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(185, 0, 229, 145),
        onTap: _onItemTapped,
      ),
      //extendBodyBehindAppBar: true,
      body: screens[_selectedIndex],
    );
  }
}

Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
    // void getUser() async {
    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(user!.uid)
    //       .get()
    //       .then((value) {
    //     loggedInUser = UserModel.fromMap(value.data());
    //     setState(() {});
    //   });
    // }
  }
