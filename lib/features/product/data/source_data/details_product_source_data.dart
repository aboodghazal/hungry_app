import 'package:dio/dio.dart';
import 'package:huungry/core/constants/api_endpoints.dart';
import 'package:huungry/core/global_model/product_model.dart';
import 'package:huungry/core/helpers/dio_helper.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/product/data/model/topping_model.dart';
 import 'package:injectable/injectable.dart';

import '../model/add_to_cart_model.dart';

abstract class DetailsProductSourceData {
  Future<ProductModel> getDataDetails(int idProduct);
  Future<ToppingResponseModel> getTopping();
  Future<ToppingResponseModel> getOptions();
  Future<String> addToCart(AddToCartModel cartItemModel);
}

@Injectable(as: DetailsProductSourceData)
class DetailsProductSourceDataImp implements DetailsProductSourceData{
  @override
  Future<ProductModel> getDataDetails(int idProduct) async {
    try{
      final response = await DioHelper.getData(url: getProductDetails(idProduct));
      if(response.statusCode ==200 || response.statusCode == 201){
        return ProductModel.fromJson(response.data['data']);
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    }on DioException catch(error){
      throw ServerFailure.fromDioError(error);
    }
  }

  @override
  Future<ToppingResponseModel> getTopping() async{
    try{
      final response = await DioHelper.getData(url: getToppings);
      if(response.statusCode == 200 || response.statusCode == 201){
        return ToppingResponseModel.fromJson(response.data);
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    }on DioException catch(e){
      throw ServerFailure.fromDioError(e);
    }

  }

  @override
  Future<ToppingResponseModel> getOptions() async{
  try{
    final response  = await DioHelper.getData(url: getSideOptions);
    if(response.statusCode == 200 || response.statusCode ==201){
      return ToppingResponseModel.fromJson(response.data);
    }else{
      throw ServerFailure.fromResponse(response.statusCode!, response.data);
    }
  } on DioException catch(e){
    throw ServerFailure.fromDioError(e);
  }
  }

  @override
  Future<String> addToCart(AddToCartModel addToCartModel) async {
    try {

      final response = await DioHelper.postData(
         url: addToCarts,
        needFormData: false,
        body: {
          "items": [
            addToCartModel.toJson(),
          ]
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw ServerFailure.fromResponse(
            response.statusCode!, response.data);
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }




}