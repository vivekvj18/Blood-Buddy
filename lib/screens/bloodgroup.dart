import 'package:bloodbuddyfinal/models/blood_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:bloodbuddyfinal/screens/otp_page.dart';
import 'package:bloodbuddyfinal/screens/signup_page.dart';
import 'package:bloodbuddyfinal/services/firebase_auth_methods.dart';

import 'home_screen.dart';

class BloodGroupScreen extends StatefulWidget {
  const BloodGroupScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<BloodGroupScreen> createState() => _BloodGroupScreenState();
}

class _BloodGroupScreenState extends State<BloodGroupScreen> {
  late bool isPasswordVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isCredCorrect = true;
  void loginUser() {
    // "running");
    context.read<FirebaseAuthMethods>().loginWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Choose your Blood Group",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 23,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 7.5, 15, 7.5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    String uid = widget.title;
                    postBloodGroup("A+", uid);
                  },
                  child: Center(
                    child: Text(
                      "A+",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 5,
                  minimumSize: const Size(120, 50),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                  primary: Colors.black,
                ),
                onPressed: () {
                  String uid = widget.title;
                  postBloodGroup("A-", uid);
                },
                child: Center(
                  child: Text(
                    "A-",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 7.5, 15, 7.5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    String uid = widget.title;
                    postBloodGroup("B+", uid);
                  },
                  child: Center(
                    child: Text(
                      "B+",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 5,
                  minimumSize: const Size(120, 50),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                  primary: Colors.black,
                ),
                onPressed: () {
                  String uid = widget.title;
                  postBloodGroup("B-", uid);
                },
                child: Center(
                  child: Text(
                    "B-",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 7.5, 15, 7.5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    String uid = widget.title;
                    postBloodGroup("O+", uid);
                  },
                  child: Center(
                    child: Text(
                      "O+",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 5,
                  minimumSize: const Size(120, 50),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                  primary: Colors.black,
                ),
                onPressed: () {
                  String uid = widget.title;
                  postBloodGroup("O-", uid);
                },
                child: Center(
                  child: Text(
                    "O-",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 7.5, 15, 7.5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    String uid = widget.title;
                    postBloodGroup("AB+", uid);
                  },
                  child: Center(
                    child: Text(
                      "AB+",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 5,
                  minimumSize: const Size(120, 50),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 255, 162),
                  primary: Colors.black,
                ),
                onPressed: () {
                  String uid = widget.title;
                  postBloodGroup("AB-", uid);
                },
                child: Center(
                  child: Text(
                    "AB-",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }

  Future<void> postBloodGroup(String s, String uid) async {
    // "postBloodGroup");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    blood upload = blood(uid: uid, bloodType: s);
    await firebaseFirestore.collection('blood').doc(uid).set(upload.toMap()).then((value) =>
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false));
  }
}
