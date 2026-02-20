import 'package:dartz/dartz.dart';
 import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/repository/home_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';

@injectable
class GetCategoryUseCase {
  HomeRepo homeRepo;
  GetCategoryUseCase(this.homeRepo);

  Future<Either<ServerFailure, CategoryResponseEntity>> call(){
    return homeRepo.getCategory();
  }
}