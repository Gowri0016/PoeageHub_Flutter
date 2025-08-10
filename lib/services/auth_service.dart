import '../core/exceptions.dart';
import '../models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Handles all user authentication (login, signup, Firebase Auth)
class AuthService extends ChangeNotifier {
  AppUser? _currentUser;
  bool _loggedIn = false;

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _loggedIn;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await _loadUserFromFirestore(user.uid);
        _loggedIn = true;
        notifyListeners();
      } else {
        throw AuthException('No user found');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Login failed');
    }
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String gender,
    required String dob,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        final appUser = AppUser(
          uid: user.uid,
          name: name,
          email: email,
          phone: phone,
          address: address,
          gender: gender,
          dob: dob,
        );
        await _firestore.collection('users').doc(user.uid).set(appUser.toMap());
        _currentUser = appUser;
        _loggedIn = true;
        notifyListeners();
      } else {
        throw AuthException('Sign up failed');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Sign up failed');
    }
  }

  Future<void> sendSignInLinkToEmail(String email) async {
    final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://poeage-hub.firebaseapp.com/finishSignUp',
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.poeage.hub',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );
    await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );
  }

  Future<void> signInWithEmailLink(String email, String emailLink) async {
    try {
      final credential = await _auth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
      final user = credential.user;
      if (user != null) {
        await _loadUserFromFirestore(user.uid);
        _loggedIn = true;
        notifyListeners();
      } else {
        throw AuthException('No user found');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Login with link failed');
    }
  }

  // Phone Auth
  String? _verificationId;
  Future<void> sendOtp(
    String phone,
    Function(String) codeSent,
    Function(String) error,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        error(e.message ?? 'Phone verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyOtp({
    required String otp,
    required String phone,
    required String name,
    required String email,
    required String address,
    required String gender,
    required String dob,
  }) async {
    if (_verificationId == null) throw AuthException('No verification ID');
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    final userCred = await _auth.signInWithCredential(credential);
    final user = userCred.user;
    if (user != null) {
      final appUser = AppUser(
        uid: user.uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
        gender: gender,
        dob: dob,
      );
      await _firestore.collection('users').doc(user.uid).set(appUser.toMap());
      _currentUser = appUser;
      _loggedIn = true;
      notifyListeners();
    } else {
      throw AuthException('OTP verification failed');
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) throw AuthException('Google sign-in cancelled');
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCred = await _auth.signInWithCredential(credential);
    final user = userCred.user;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        // Use existing Firestore profile data
        _currentUser = AppUser.fromMap(doc.data()!);
      } else {
        // Create new profile with Google data
        final appUser = AppUser(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          address: '',
          gender: '',
          dob: '',
        );
        await _firestore.collection('users').doc(user.uid).set(appUser.toMap());
        _currentUser = appUser;
      }
      _loggedIn = true;
      notifyListeners();
    } else {
      throw AuthException('Google sign-in failed');
    }
  }

  Future<void> _loadUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      _currentUser = AppUser.fromMap(doc.data()!);
    }
  }

  void signOut() {
    _currentUser = null;
    _loggedIn = false;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    required String gender,
    required String dob,
  }) async {
    final user = _auth.currentUser;
    if (user == null || _currentUser == null) {
      throw AuthException('Not logged in');
    }
    final updatedUser = AppUser(
      uid: user.uid,
      name: name,
      email: _currentUser!.email,
      phone: phone,
      address: address,
      gender: gender,
      dob: dob,
    );
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(updatedUser.toMap(), SetOptions(merge: true));
    _currentUser = updatedUser;
    notifyListeners();
  }
}
