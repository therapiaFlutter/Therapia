import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<UserCredential> registerUser(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}