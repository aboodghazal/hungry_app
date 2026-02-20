

import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/domain/reposoitry/cart_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class DeleteItemCartUseCase {
  final CartRepo cartRepo;

  DeleteItemCartUseCase(this.cartRepo);

  Future<Either<ServerFailure,String>>  call(int idItem){
    return cartRepo.deleteItemCart(idItem);
  }
}