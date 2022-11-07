import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/screens/tnc_page.dart';
import 'package:bloodbuddyfinal/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late bool userImg = false;

  Uri insta = Uri.parse('https://www.instagram.com/bloodbuddyfinal/');
  Uri website = Uri.parse('https://bloodbuddyfinal.in/');
  Uri twt = Uri.parse('https://twitter.com/go_selectric');
  Uri fb = Uri.parse('https://m.facebook.com/bloodbuddyfinal.official');
  Uri lin = Uri.parse('https://www.linkedin.com/company/bloodbuddyfinal/');
  Uri discord = Uri.parse('https://discord.com/invite/hmGaGdUkcT');
  @override
  void initState() {
    // context.read<FirebaseAuthMethods>().user.photoURL);
    if (context.read<FirebaseAuthMethods>().user.photoURL == null) {
      userImg = false;
    } else {
      userImg = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(238, 255, 255, 255),
                Color.fromARGB(92, 255, 255, 255)
              ],
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Container(
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // UserAccountsDrawerHeader(
              //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              //   accountName: Text(
              //     user.displayName ?? '',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold),
              //   ),
              //   accountEmail: user.email == null
              //       ? (Text(user.phoneNumber ?? '',
              //           style: const TextStyle(
              //               color: Colors.black,
              //               fontSize: 15,
              //               fontWeight: FontWeight.bold)))
              //       : Text(
              //           '${user.email}',
              //           style: const TextStyle(
              //             color: Colors.black,
              //             fontSize: 15,
              //           ),
              //         ),
              //   currentAccountPicture: CircleAvatar(
              //     child: ClipOval(
              //         child: userImg
              //             ? Image.network(
              //                 user.photoURL ?? '',
              //               )
              //             : Icon(
              //                 Icons.person,
              //               )),
              //   ),
              //   decoration: const BoxDecoration(
              //     color: Colors.transparent,
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                child: ClipOval(
                    child: userImg
                        ? Image.network(
                            user.photoURL ?? '',
                          )
                        : const Icon(
                            Icons.person,
                          )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  user.displayName ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (!user.emailVerified)
                (ListTile(
                  title: const Text('Verify Email'),
                  leading: const Icon(Icons.mail),
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .sendEmailVerification(context);
                  },
                )),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  // "tapped");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.readme),
                title: const Text('Terms & Conditions'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TNCScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_support),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
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
                                  "About Us",
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
                                        "A very long about us text",
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
                                        "Some set of social icons, maybe be useful later",
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
                                            icon: const Icon(
                                                FontAwesomeIcons.facebook),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(twt),
                                            icon: const Icon(
                                                FontAwesomeIcons.twitter),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () =>
                                                _launchUrl(discord),
                                            icon: const Icon(
                                                FontAwesomeIcons.discord),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () => _launchUrl(lin),
                                            icon: const Icon(
                                                FontAwesomeIcons.linkedin),
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
                },
              ),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ListTile(
                leading: const Text("Useful Numbers"),
                onTap: () {
                  _launchUrl(fb);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.phone),
                title: const Text('Police'),
                onTap: () {
                  _launchUrl(fb);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.hospital),
                title: const Text('Ambulance'),
                onTap: () {
                  _launchUrl(insta);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.star),
                title: const Text('Another useful number'),
                onTap: () {
                  _launchUrl(twt);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.star),
                title: const Text('Another useful number'),
                onTap: () {
                  _launchUrl(discord);
                },
              ),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ListTile(
                title: const Text('Sign Out'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
              ),
              // ListTile(
              //   title: const Text('Delete Account'),
              //   leading: const Icon(Icons.delete),
              //   onTap: () {
              //     context.read<FirebaseAuthMethods>().deleteAccount(context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    print("button pressed");
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
}
