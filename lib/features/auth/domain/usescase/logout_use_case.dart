import 'package:dartz/dartz.dart';
import 'package:huungry/features/auth/domain/reposoitry/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../entity/user_entity.dart';

@injectable
class LogoutUseCase {
  AuthRepo authRepo;
  LogoutUseCase(this.authRepo);

  Future<Either<ServerFailure, String>> call(){
    return authRepo.logout();
  }
}