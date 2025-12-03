import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provide/firebase_options.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/contacts.readonly'
    ],
  );

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<User?> signInWithGoogle() async {
    try {
      // For web platform
      if (kIsWeb) {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) return null;
        
        final GoogleSignInAuthentication googleAuth = 
            await googleUser.authentication;
        
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        
        final UserCredential userCredential = 
            await FirebaseAuth.instance.signInWithCredential(credential);
        
        return userCredential.user;
      }
      
      // For mobile platforms (Android/iOS)
      else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) return null;
        
        final GoogleSignInAuthentication googleAuth = 
            await googleUser.authentication;
        
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        
        final UserCredential userCredential = 
            await FirebaseAuth.instance.signInWithCredential(credential);
        
        return userCredential.user;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  static Future<User?> getCurrentUser() {
    return Future.value(FirebaseAuth.instance.currentUser);
  }

  // For server-side authentication (optional)
  static Future<String?> getServerAuthCode() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
    
    if (googleUser == null) return null;
    
    final GoogleSignInAuthentication googleAuth = 
        await googleUser.authentication;
    
    return googleAuth.serverAuthCode;
  }
}