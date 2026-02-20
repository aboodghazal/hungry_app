import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';

import '../entity/cart_entity.dart';

abstract class CartRepo {
  Future<Either<ServerFailure,CartResponseEntity>> getCart();
  Future<Either<ServerFailure,String>> deleteItemCart(int idItem);
}