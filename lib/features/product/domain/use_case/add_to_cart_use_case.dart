
import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/product/data/model/add_to_cart_model.dart';
import 'package:huungry/features/product/data/reposoitry/details_product_repo_imp.dart';
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase {
  final DetailsProductRepo detailsProductRepo;

  AddToCartUseCase(this.detailsProductRepo);

  Future<Either<ServerFailure,String>> call(AddToCartModel cartItem){
    return detailsProductRepo.addToCart(cartItem);
  }
}