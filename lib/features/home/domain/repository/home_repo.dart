import 'package:dartz/dartz.dart';
import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';

import '../../../../core/network/failure.dart';

abstract class HomeRepo {
  Future<Either<ServerFailure, CategoryResponseEntity>> getCategory();
  Future<Either<ServerFailure, ProductResponseEntity>> getProduct();
  Future<Either<ServerFailure, ProductResponseEntity>> getProductByCategories(int idCate);
  Future<Either<ServerFailure, String>> toggleFavorite(int idProduct);


}