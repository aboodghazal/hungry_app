import 'package:dartz/dartz.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
 import 'package:huungry/features/auth/domain/entity/user_entity.dart';

import '../../../../core/network/failure.dart';

abstract class AuthRepo {
  Future<Either<ServerFailure, UserEntity>> login(String email, String password);
  Future<Either<ServerFailure, UserEntity>> signUp(String name ,String email, String password);
  Future<Either<ServerFailure, UserEntity>> getProfile();
  Future<Either<ServerFailure, String >> logout();
  Future<Either<ServerFailure, String >> updateProfile(UserModel userModel);


}