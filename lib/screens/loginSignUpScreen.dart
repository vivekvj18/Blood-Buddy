import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/screens/login.dart';
import 'package:bloodbuddyfinal/screens/signup_page.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                children: const <TextSpan>[
                  TextSpan(text: 'All Purpose Safety App', style: TextStyle()),
                ],
              ),
            ),
            const Spacer(),
            Image.asset('assets/car-ill.png', width: 316, height: 253),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                elevation: 5,
                minWidth: const Size.fromHeight(50).width,
                color: const Color.fromARGB(255, 0, 255, 162),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginaScreen(title: 'a'),
                    ),
                  );
                },
                child: Text(
                  "Log In",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 63),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                elevation: 5,
                minWidth: const Size.fromHeight(50).width,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(title: ''),
                    ),
                  );
                },
                child: Text(
                  "Create account",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
