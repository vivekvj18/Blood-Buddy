import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bloodbuddyfinal/blocs/application_bloc.dart';
import 'package:bloodbuddyfinal/firebase_options.dart';
import 'package:bloodbuddyfinal/screens/first_screen.dart';
import 'package:bloodbuddyfinal/screens/home_screen.dart';
import 'package:bloodbuddyfinal/screens/login_email_password_screen.dart';
import 'package:bloodbuddyfinal/screens/login_screen.dart';
import 'package:bloodbuddyfinal/screens/signup_email_password_screen.dart';
import 'package:bloodbuddyfinal/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloodbuddyfinal/services/s_local_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // I am back baby!!!!!!
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SLocalNotification.initialize();
  // SLocalNotification.show(message);
  print('Handling a background message: ${message.messageId}');
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  description: 'Shows notifications for high importance',
  importance: Importance.high,
  showBadge: true,
  enableLights: true,
  enableVibration: true,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessgingBackgroundHandler(RemoteMessage message) async {
  FlutterLocalNotificationsPlugin();
  print('A bg message arrived: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: 'bloodbuddyfinal',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(171, 0, 206, 130),
      statusBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // mai hbi agaya
  // oye hoye

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
          //first comment
          // mai pehle aya
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'bloodbuddyfinal',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 0, 255, 162),
        ),
        home: const AuthWrapper(),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      final applicationBloc =
          Provider.of<ApplicationBloc>(context, listen: false);
      applicationBloc.auth = firebaseUser;
      log('[AuthWrapper]: firebaseUser != null ${applicationBloc.auth}');
      return const HomeScreen();
      // return H();
    }
    return const MyHomePage(title: "a");
    // return H();
  }
}

// class H extends StatefulWidget {
//   const H({Key? key}) : super(key: key);

//   @override
//   _HState createState() => _HState();
// }

// class _HState extends State<H> {
//   List _items = [];
//   AutoGenerate markers = AutoGenerate(markers: []);
//   // Fetch content from the json file
//   postDetailsToFirestore() async {
//     // calling our firestore
//     // calling our user model
//     // sedning these values
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     // await firebaseFirestore
//     //     .collection("markers").add(markers.toJson()).then((value) => Fluttertoast.showToast(msg: "Account created successfully :) "));

//   }
//   Future<void> readJson() async {
//     final String response =
//         await rootBundle.loadString('assets/marker-data.json');
//     final data = await json.decode(response);
//     // "doneeeee");
//     // data);
//     setState(() {
//       _items = data["markers"];
//     });
//     // "startinggggg");
//     markers = AutoGenerate.fromJson(data);

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Kindacode.com',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           children: [
//             ElevatedButton(
//               child: const Text('Load Data'),
//               onPressed: readJson,
//             ),
//             ElevatedButton(
//               child: const Text('Send Data'),
//               onPressed: postDetailsToFirestore,
//             ),
//             // Display the data loaded from sample.json
//             markers.markers.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                       itemCount: _items.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: const EdgeInsets.all(10),
//                           child: ListTile(
//                             leading: Text(markers.markers[index].no.toString()),
//                             title: Text(_items[index]["region"]),
//                             subtitle: Text(_items[index]["address"]),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }
