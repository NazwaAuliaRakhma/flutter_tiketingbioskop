import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<void> login({required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something wrong!';
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        'username': username,
        'email': email,
      });
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something wrong!';
    } catch (e) {
      throw e;
    }
  }
}
