import 'package:dartz/dartz.dart';
import 'package:huungry/features/auth/domain/reposoitry/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../entity/user_entity.dart';

@injectable
class LoginUseCase {
AuthRepo authRepo;
LoginUseCase(this.authRepo);

Future<Either<ServerFailure, UserEntity>> call(String email, String password){
  return authRepo.login(email, password);
}
}