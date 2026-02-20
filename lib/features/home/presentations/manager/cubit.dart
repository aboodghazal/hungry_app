import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huungry/core/global_model/product_model.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:huungry/features/auth/domain/entity/user_entity.dart';

import 'package:huungry/features/home/data/models/category_model.dart';
import 'package:huungry/features/home/data/models/home_model.dart';
import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/home/domain/use_case/get_category_use_case.dart';
import 'package:huungry/features/home/domain/use_case/get_product_by_cate_use_case.dart';
import 'package:huungry/features/home/domain/use_case/get_product_use_case.dart';
import 'package:huungry/features/home/domain/use_case/toggle_favorite_use_case.dart';
import 'package:huungry/features/home/presentations/manager/state.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cached/app_controller.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {

  static HomeCubit get(context) => BlocProvider.of(context);

  final GetCategoryUseCase getCategoryUseCase;
  final GetProductUseCase getProductUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetProductByCateUseCase getProductByCateUseCase;

   CategoryResponseEntity categories = CategoryResponseModel.empty().toEntity();
   ProductResponseEntity products = ProductResponseModel.empty().toEntity();

   final List<ProductEntity> listSearchProduct = [];

   UserEntity userEntity = UserModel.emptyOne().toEntity();



  HomeCubit(this.getCategoryUseCase, this.getProductUseCase, this.toggleFavoriteUseCase, this.getProductByCateUseCase) : super(HomeInitial());


/*  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        getCategoryUseCase.call(),
        getProductUseCase.call(),
      ]);

      final categoryResult = results[0] ;
      final productResult = results[1];

      categoryResult.fold(
            (failure) => emit(HomeFailure(failure.message)),
            (cate) => categories = cate as CategoryResponseEntity,
      );

      productResult.fold(
            (failure) => emit(HomeFailure(failure.message)),
            (prod) => products = prod as ProductResponseEntity,
      );

      // ✅ بعد ما يكتمل كل شيء
      emit(HomeLoaded(
        categories: categories.listCate,
        products: products.products,
      ));

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }*/



  void getUserData() async {

      final userModel = await AppController.instance.getUser();
      userEntity = userModel.toEntity();
      emit(UserLoaded(userEntity));

  }
  void searchData(String value){

    listSearchProduct.clear();
    if(value.isEmpty){
      emit(ProductLoaded(products: products.products));

    }else{
      final filters = products.products.where((element) => element.name.toLowerCase().contains(value.toLowerCase()),).toList();
      emit(ProductLoaded(products: filters));

    }
  }

  Future<void> toggleFav(int idProduct)async{

    final result = await toggleFavoriteUseCase.call(idProduct);

    result.fold((l) {
      emit(ProductError(l.message));
    }, (r) {

    },);
  }

  Future<void> getCategory() async {
    emit(CateLoading());

    final result = await getCategoryUseCase.call();

    result.fold((failure) => emit(CateError(failure.message)),
          (cate) {
            categories = cate;
            emit(CateLoaded( listCate: cate.listCate));
          }
    );

  }


  Future<void> getProductByCate(int idCate) async{
    emit(ProductLoading());

    final result = await getProductByCateUseCase.call(idCate);

    result.fold((failure) => emit(ProductError(failure.message)),
            (product) {
          products = product;
          emit(ProductLoaded( products: product.products));
        }
    );
  }

  Future<void> getProduct() async {
    emit(ProductLoading());

    final result = await getProductUseCase.call();

    result.fold((failure) => emit(ProductError(failure.message)),
            (product) {
          products = product;
          emit(ProductLoaded( products: product.products));
        }
    );

  }





}
