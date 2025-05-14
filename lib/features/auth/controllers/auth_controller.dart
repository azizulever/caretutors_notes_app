import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = _auth.currentUser;
    debugPrint("Current user on init: ${firebaseUser.value?.uid}");
    
    _auth.authStateChanges().listen((User? user) {
      debugPrint("Auth state changed: ${user?.uid}");
      firebaseUser.value = user;
      
      // Clear controllers when user changes
      if (user == null) {
        // Use string-based removal to avoid circular imports
        if (Get.isRegistered(tag: 'notesController')) {
          Get.delete(tag: 'notesController');
        }
      }
    });
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      isLoading.value = true;
      
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      // Store additional user information in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
          'email': email.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      return null; // Return null if successful
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Return null if successful
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("User signed out");
      
      // Clean up controllers using string-based approach
      if (Get.isRegistered(tag: 'notesController')) {
        Get.delete(tag: 'notesController');
      }
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  bool isUserSignedIn() {
    final isSignedIn = _auth.currentUser != null;
    debugPrint("Is user signed in: $isSignedIn (${_auth.currentUser?.uid})");
    return isSignedIn;
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }
}
