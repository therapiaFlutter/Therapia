import 'package:dartz/dartz.dart';
import 'package:therapia_flutter_application/core/failures/failures.dart';
import 'package:therapia_flutter_application/features/auth/domain/repositories/user_repository.dart';


class SignOutUserUseCase {
  final UserRepository userRepository;

  SignOutUserUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.signOut();
  }
}
