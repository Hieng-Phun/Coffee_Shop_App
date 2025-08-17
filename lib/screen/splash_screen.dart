// splash_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:testing/screen/home_screen.dart';
import 'package:testing/screen/signin_screen.dart'; // Required for Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use a Timer to wait for a moment, then check auth state.
    Timer(const Duration(seconds: 4), () {
      _checkAuthState();
    });
  }

  void _checkAuthState() {
    // Get the current user from the Firebase Auth instance.
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If a user is logged in, navigate to the Home Screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // If no user is logged in, navigate to the Sign In Screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is the UI for your splash screen.
    return Scaffold(
      backgroundColor: Colors.amber, // Use your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display your app logo or name here.
            Image.asset(
              'assets/logo.png', // You need to add this asset.
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
