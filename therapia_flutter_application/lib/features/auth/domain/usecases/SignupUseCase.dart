import 'package:firebase_auth/firebase_auth.dart';
import 'package:therapia_flutter_application/features/auth/data/repositories/FirestoreRepository.dart';
import 'package:therapia_flutter_application/features/auth/domain/repositories/AuthRepository.dart';

class SignupUseCase {
  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;

  SignupUseCase(this._authRepository, this._firestoreRepository);

  Future<void> execute({
    required String email,
    required String password,
    required Function(User) onSuccess,
    required Function(dynamic) onError,
  }) async {
    try {
      await _authRepository.registerUser(email, password).then((value) async {
        onSuccess(value.user!);
        await _firestoreRepository.postDetailsToFirestore(email, 'student');
      }).catchError((e) {
        onError(e);
      });
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }
}