import 'package:dartz/dartz.dart';
import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/home/domain/repository/home_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';

@injectable
class GetProductUseCase {
  HomeRepo homeRepo;
  GetProductUseCase(this.homeRepo);

  Future<Either<ServerFailure, ProductResponseEntity>> call(){
    return homeRepo.getProduct();
  }
}