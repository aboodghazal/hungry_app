

import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/source_data/cart_source_data.dart';
import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/cart/domain/reposoitry/cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:CartRepo )
class CartRepoImp implements CartRepo {
  final CartSourceData cartSourceData;

  CartRepoImp({required this.cartSourceData});
  @override
  Future<Either<ServerFailure, CartResponseEntity>> getCart() async {
    try{
      final response = await cartSourceData.getCart();
      return Right(response.toEntity());
    } on ServerFailure catch(e){
      return Left(e);
    }
  }

  @override
  Future<Either<ServerFailure, String>> deleteItemCart(int idItem) async{
    try{
      final response = await cartSourceData.deleteItemCart(idItem);
      return Right(response);
    } on ServerFailure catch(e){
      return Left(e);
    }
  }

}