import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      // Sign out from Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In (if user signed in with Google)
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      // Navigate back to the Welcome screen
      Navigator.pushNamed(context, '/welcome');
    } catch (error) {
      // Handle sign-out errors
      print('Error signing out: $error');
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Navigate to the DashboardScreen after successful sign-in
        if (userCredential.user != null) {
          Navigator.pushNamed(context, '/dashboard');
        }
      }
    } catch (error) {
      // Handle sign-in with Google errors
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the DashboardScreen when button is pressed
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the SignUpScreen when button is pressed
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up'),
            ),
            OutlinedButton(
              onPressed: () {
                // Perform Google login logic
                _signInWithGoogle(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/google_logo.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 10),
                  Text('Sign in with Google'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Sign out button pressed
                _signOut(context);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
