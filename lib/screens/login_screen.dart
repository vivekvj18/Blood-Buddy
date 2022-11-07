import 'package:bloodbuddyfinal/screens/login_email_password_screen.dart';
import 'package:bloodbuddyfinal/screens/signup_email_password_screen.dart';
import 'package:bloodbuddyfinal/services/firebase_auth_methods.dart';
import 'package:bloodbuddyfinal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.01, 0.2, 1],
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/icon.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const SizedBox(height: 45),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EmailPasswordSignup.routeName);
                    },
                    text: 'Email Sign Up',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EmailPasswordLogin.routeName);
                    },
                    text: 'Email Login',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onTap: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .signInWithGoogle(context);
                    },
                    text: 'Google Sign In',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
