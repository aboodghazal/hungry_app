import 'package:dartz/dartz.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:huungry/features/auth/domain/reposoitry/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../entity/user_entity.dart';

@injectable
class UpdateProfileUseCase {
  AuthRepo authRepo;
  UpdateProfileUseCase(this.authRepo);

  Future<Either<ServerFailure, String>> call(UserModel userModel){
    return authRepo.updateProfile(userModel);
  }
}