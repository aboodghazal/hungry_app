import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/product/data/source_data/details_product_source_data.dart';
import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart';
import 'package:injectable/injectable.dart';

import '../model/add_to_cart_model.dart';

@Injectable(as: DetailsProductRepo)
class DetailsProductRepoImp implements DetailsProductRepo{
  final DetailsProductSourceData detailsProductSourceData;

  DetailsProductRepoImp(this.detailsProductSourceData);

  @override
  Future<Either<ServerFailure, ProductEntity>> getProductDetails(int idProduct) async {
    try{
      final response  = await detailsProductSourceData.getDataDetails(idProduct);
      return Right(response.toEntity());
    }on ServerFailure catch(e){
      return Left(e);
    }
  }

  @override
  Future<Either<ServerFailure, ToppingResponseEntity>> getTopping() async {
    try{
      final response = await detailsProductSourceData.getTopping();
      return Right(response.toEntity());
    }on ServerFailure catch(e){
      return Left(e);
    }

  }

  @override
  Future<Either<ServerFailure, ToppingResponseEntity>> getOptions() async{
    try{
      final response = await detailsProductSourceData.getOptions();
      return Right(response.toEntity());
    } on ServerFailure catch(e){
      return Left(e);
    }
  }

  @override
  Future<Either<ServerFailure, String>> addToCart(AddToCartModel addToCartModel)async {
     try{
       final response = await detailsProductSourceData.addToCart(addToCartModel);
       return Right(response);
     }on ServerFailure catch(e){
       return Left(e);
     }
  }

}