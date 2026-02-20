import 'package:dio/dio.dart';
import 'package:huungry/core/helpers/dio_helper.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_endpoints.dart';

abstract class CartSourceData {
  Future<CartResponseModel> getCart();
  Future<String> deleteItemCart(int itemId);
}

@Injectable(as: CartSourceData)
class CartSourceDataImp implements CartSourceData{
  @override
  Future<CartResponseModel> getCart() async{
    try{
      final response = await DioHelper.getData(url: getCarts);
      if(response.statusCode == 200 || response.statusCode == 201){
        return CartResponseModel.fromJson(response.data);
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    }on DioException catch(e){
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future<String> deleteItemCart(int itemId)async {
    try{
      final response = await DioHelper.deleteData(url:  deleteItemCarts(itemId));
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.data['message'];
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    }on DioException catch(e){
      throw ServerFailure.fromDioError(e);
    }
  }


}