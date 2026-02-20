import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/cart/domain/reposoitry/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUseCase {
  final CartRepo cartRepo;

  GetCartUseCase({required this.cartRepo});
    Future<Either<ServerFailure,CartResponseEntity>> call(){
      return cartRepo.getCart();
    }

}