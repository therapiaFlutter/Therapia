import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepository {
  Future<void> postDetailsToFirestore(String email, String role) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref.doc(user!.uid).set({'email': email, 'role': role});
  }
}