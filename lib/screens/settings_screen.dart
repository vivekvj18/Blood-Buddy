import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bloodbuddyfinal/screens/sidebar_screen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:bloodbuddyfinal/screens/tnc_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/firebase_auth_methods.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hasBiometricsEnabled = false;

  Uri website = Uri.parse('http://www.bloodbuddyfinal.in/');

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: const NavBar(),
    );
  }

  Widget get body {
    return SettingsList(
      lightTheme:
          const SettingsThemeData(settingsListBackground: Colors.transparent),
      sections: [
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              trailing: const Icon(Icons.notifications_active_rounded),
              title: Text(
                'Notification',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SettingsTile.navigation(
              trailing: Text(
                'Delhi',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              title: Text(
                'State',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SettingsTile.navigation(
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TNCScreen(),
                  ),
                );
              },
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Terms of Service',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SettingsTile.navigation(
              onPressed: (context) {
                _launchUrl(website);
              },
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Help Center',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SettingsTile.navigation(
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Give Feedback',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SettingsTile.navigation(
              onPressed: (context) =>
                  {context.read<FirebaseAuthMethods>().signOut(context)},
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Log out',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar get appBar {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Settings",
        style: TextStyle(
            color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    throw 'Could not launch $_url';
    // if (!await launchUrl(_url)) {
    //   throw 'Could not launch $_url';
    // }
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

  void toggleBiometricsLogin(val) async {
    setState(() {});
  }
}
