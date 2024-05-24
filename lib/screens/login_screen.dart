import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () async {
            final UserCredential? userCredential = await signInWithGoogle();
            if (userCredential != null) {
              // Navigate to the next screen or perform any other actions
            } else {
              // Handle sign-in failure
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}

FlatButton({required Future<Null> Function() onPressed, required Text child}) {
}
