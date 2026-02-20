import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
 import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetToppingUseCase {
  DetailsProductRepo detailsProductRepo;
  GetToppingUseCase(this.detailsProductRepo);
  Future<Either<ServerFailure,ToppingResponseEntity>> call(){
    return detailsProductRepo.getTopping();
  }
}