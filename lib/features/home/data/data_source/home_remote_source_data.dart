import 'package:dio/dio.dart';
import 'package:huungry/core/helpers/dio_helper.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/home/data/models/category_model.dart';
import 'package:huungry/features/home/data/models/home_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_endpoints.dart';

abstract class HomeRemoteSourceData {
  Future<CategoryResponseModel> getCategory();
  Future<ProductResponseModel> getProduct();
  Future<ProductResponseModel> getProductByCategory(int idCate);
  Future<String> toggleFavorite (int idProduct);

}

@Injectable(as: HomeRemoteSourceData)
class HomeRemoteSourceDataImp implements HomeRemoteSourceData{

  @override
  Future<CategoryResponseModel> getCategory() async{
    try{
      final response = await DioHelper.getData(url: getCategorys);
      if(response.statusCode == 200 || response.statusCode == 201){
        return CategoryResponseModel.fromJson(response.data);
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch(e){
      throw ServerFailure.fromDioError(e);

    }
   }

  @override
  Future<ProductResponseModel> getProduct() async{
     try{
       final response = await DioHelper.getData(url: getProducts);
       if(response.statusCode == 200 || response.statusCode == 201){
         return ProductResponseModel.fromJson(response.data);
       }else{
         throw ServerFailure.fromResponse(response.statusCode!, response.data);
       }
     } on DioException catch(e){
       throw ServerFailure.fromDioError(e);
     }
  }

  @override
  Future<String> toggleFavorite(int idProduct) async {
   try{
     final response  = await DioHelper.postData(url: toggleFav,body: {
       'product_id':idProduct
     });
     if(response.statusCode == 200 || response.statusCode == 201){
       return response.data['message'];
     }else{
       throw ServerFailure.fromResponse(response.statusCode!, response.data);
     }
   }on DioException catch(e){
     throw ServerFailure.fromDioError(e);
   }
  }

  @override
  Future<ProductResponseModel> getProductByCategory(int cateId) async{
    try{
      final response  = await DioHelper.getData(url:getProducts,query: {
        'category_id':cateId,
      } );
      if(response.statusCode == 200 || response.statusCode == 201){
        return ProductResponseModel.fromJson(response.data);

      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch(e){
      throw ServerFailure.fromDioError(e);
    }
  }
}
