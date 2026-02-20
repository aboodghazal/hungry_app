
import 'package:dartz/dartz.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/home_repo.dart';
import '../data_source/home_remote_source_data.dart';

@Injectable(as: HomeRepo)

class HomeRepoImp implements HomeRepo{
  final HomeRemoteSourceData homeRemoteSourceData;

  HomeRepoImp({required this.homeRemoteSourceData});

  @override
  Future<Either<ServerFailure, CategoryResponseEntity>> getCategory() async {
      try{
        final response = await homeRemoteSourceData.getCategory();
        return Right(response.toEntity());
      }on ServerFailure catch(e){
        return Left(e);

      }
  }

  @override
  Future<Either<ServerFailure, ProductResponseEntity>> getProduct() async {
   try{
     final response  = await homeRemoteSourceData.getProduct();
     return Right(response.toEntity());
   }on ServerFailure catch(error){
     return Left(error);
   }
  }

  @override
  Future<Either<ServerFailure, String>> toggleFavorite(int idProduct) async{
    try{
      final response = await homeRemoteSourceData.toggleFavorite(idProduct);
      return Right(response);
    } on ServerFailure catch(e){
      return Left(e);
    }
  }

  @override
  Future<Either<ServerFailure, ProductResponseEntity>> getProductByCategories(int idCate) async {
    try{
      final response  = await homeRemoteSourceData.getProductByCategory(idCate);
      return Right(response.toEntity());
    } on ServerFailure catch(e){
      return Left(e);
    }
  }
 }