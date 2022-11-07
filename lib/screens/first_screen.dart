import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodbuddyfinal/screens/loginSignUpScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Image.asset('assets/jagah.png',
                height: 205, width: 244, fit: BoxFit.contain),
            RichText(
              text: TextSpan(
                style: GoogleFonts.ptSans(
                  textStyle: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 46,
                      fontWeight: FontWeight.w700),
                ),
                children: const <TextSpan>[
                  TextSpan(text: ' Stri', style: TextStyle()),
                  TextSpan(
                      text: 'Zone',
                      style:
                          TextStyle(color: Color.fromARGB(225, 22, 217, 147))),
                ],
              ),
            ),
            Text(
              'Into the zone',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                minWidth: const Size.fromHeight(50).width,
                color: const Color.fromARGB(255, 0, 255, 162),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginSignupScreen(title: 'a'),
                    ),
                  );
                },
                child: Text(
                  "Let's Start",
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 94),
              child: Text(
                "Click to continue",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
