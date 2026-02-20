import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsProductUseCase {
  DetailsProductRepo detailsProductRepo;
  DetailsProductUseCase(this.detailsProductRepo);
  Future<Either<ServerFailure,ProductEntity>> call(int idProduct){
    return detailsProductRepo.getProductDetails(idProduct);
  }
}