import 'package:dio/dio.dart';
import 'package:huungry/core/cached/app_controller.dart';
import 'package:huungry/core/helpers/dio_helper.dart';
import 'package:huungry/core/helpers/helper_function.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_endpoints.dart';

abstract class AuthRemoteSourceData {
  Future<UserModel> login (String email, String password) ;
  Future<UserModel> SignUp (String name,String email, String password) ;
  Future<UserModel> getProfileData () ;
  Future<String> updateProfile(UserModel userModel);

  Future<String> logout () ;

}


@Injectable(as: AuthRemoteSourceData)
class AuthRemoteSourceDataImp implements AuthRemoteSourceData{
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await DioHelper.postData(url: logins,body:  {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
         final userData = UserModel.fromJson(response.data['data']);

         await loginCache(data: userData, token: response.data['data']['token'] ?? '');
        return userData;
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }


    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  @override
  Future<UserModel> SignUp(String name, String email, String password) async{
    try {
      final response = await DioHelper.postData(url: signup,body:  {
        'name':name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }


    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }  }

  @override
  Future<UserModel> getProfileData() async {
   try{
     final response = await DioHelper.getData(url:getProfile );
     if(response.statusCode ==200 || response.statusCode == 201){
       return UserModel.fromJson(response.data['data']);
     }else{
       throw ServerFailure.fromResponse(response.statusCode!, response.data);
     }

   } on DioException catch (e) {
     throw ServerFailure.fromDioError(e);
   }
  }

  @override
  Future<String> logout() async{
    try{
      final response  = await DioHelper.postData(url:logouts );

      if(response.statusCode ==200 || response.statusCode == 201){
        return response.data['message'];
      }else{
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }


    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }
  @override
  Future<String> updateProfile(UserModel userModel) async {
    try {
      final response = await DioHelper.postData(
        url: updateProfiles,
        body: {
          'name': userModel.name,
          'email': userModel.email,
          'Visa': userModel.visa,
          'address': userModel.address,
          if (userModel.image != null && userModel.image!.isNotEmpty)
            'image': await MultipartFile.fromFile(
              userModel.image!,
              filename: 'profile.jpg',
            ),
        },
        needFormData: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // هنا بدل ما نخزن مسار الجهاز، نخزن رابط الصورة من السيرفر
        final userJson = response.data['data']; // يفترض السيرفر يرجع بيانات المستخدم كاملة مع رابط الصورة
        final updatedUser = UserModel.fromJson(userJson);

        await AppController.instance.setUser(updatedUser); // نخزن رابط الصورة
        return response.data['message'];
      } else {
        throw ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }


}