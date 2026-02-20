import 'package:dartz/dartz.dart';
 import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';

import '../../data/model/add_to_cart_model.dart';
import '../entitys/topping_entitys.dart';

abstract class DetailsProductRepo {
  Future<Either<ServerFailure,ProductEntity>> getProductDetails(int idProduct);
  Future<Either<ServerFailure,ToppingResponseEntity>> getTopping();
  Future<Either<ServerFailure,ToppingResponseEntity>> getOptions();
  Future<Either<ServerFailure,String>> addToCart(AddToCartModel cartItem);
 }