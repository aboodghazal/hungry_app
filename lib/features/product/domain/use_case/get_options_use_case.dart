import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOptionsUseCase {
  DetailsProductRepo detailsProductRepo;
  GetOptionsUseCase(this.detailsProductRepo);
  Future<Either<ServerFailure,ToppingResponseEntity>> call(){
    return detailsProductRepo.getOptions();
  }
}