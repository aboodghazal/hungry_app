// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:huungry/features/auth/data/data_source/auth_remote_source_data.dart'
    as _i147;
import 'package:huungry/features/auth/data/repository/auth_repo.dart' as _i596;
import 'package:huungry/features/auth/domain/reposoitry/auth_repo.dart'
    as _i635;
import 'package:huungry/features/auth/domain/usescase/get_profile_use_case.dart'
    as _i908;
import 'package:huungry/features/auth/domain/usescase/login_use_case.dart'
    as _i1039;
import 'package:huungry/features/auth/domain/usescase/logout_use_case.dart'
    as _i994;
import 'package:huungry/features/auth/domain/usescase/signup_use_case.dart'
    as _i701;
import 'package:huungry/features/auth/domain/usescase/update_profile_use_case.dart'
    as _i190;
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart'
    as _i428;
import 'package:huungry/features/cart/data/reposiotry/cart_repo_imp.dart'
    as _i143;
import 'package:huungry/features/cart/data/source_data/cart_source_data.dart'
    as _i1050;
import 'package:huungry/features/cart/domain/reposoitry/cart_repo.dart'
    as _i113;
import 'package:huungry/features/cart/domain/use_case/delete_item_cart_use_case.dart'
    as _i467;
import 'package:huungry/features/cart/domain/use_case/get_cart_use_case.dart'
    as _i1024;
import 'package:huungry/features/home/data/data_source/home_remote_source_data.dart'
    as _i486;
import 'package:huungry/features/home/data/repository/home_repo.dart' as _i1026;
import 'package:huungry/features/home/domain/repository/home_repo.dart'
    as _i933;
import 'package:huungry/features/home/domain/use_case/get_category_use_case.dart'
    as _i979;
import 'package:huungry/features/home/domain/use_case/get_product_by_cate_use_case.dart'
    as _i969;
import 'package:huungry/features/home/domain/use_case/get_product_use_case.dart'
    as _i107;
import 'package:huungry/features/home/domain/use_case/toggle_favorite_use_case.dart'
    as _i324;
import 'package:huungry/features/home/presentations/manager/cubit.dart'
    as _i152;
import 'package:huungry/features/product/data/reposoitry/details_product_repo_imp.dart'
    as _i349;
import 'package:huungry/features/product/data/source_data/details_product_source_data.dart'
    as _i592;
import 'package:huungry/features/product/domain/reposoitry/details_product_repo.dart'
    as _i698;
import 'package:huungry/features/product/domain/use_case/add_to_cart_use_case.dart'
    as _i914;
import 'package:huungry/features/product/domain/use_case/details_product_use_case.dart'
    as _i698;
import 'package:huungry/features/product/domain/use_case/get_options_use_case.dart'
    as _i494;
import 'package:huungry/features/product/domain/use_case/get_topping_use_case.dart'
    as _i245;
import 'package:huungry/features/product/presentations/manager/cubit.dart'
    as _i148;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i486.HomeRemoteSourceData>(
      () => _i486.HomeRemoteSourceDataImp(),
    );
    gh.factory<_i1050.CartSourceData>(() => _i1050.CartSourceDataImp());
    gh.factory<_i113.CartRepo>(
      () => _i143.CartRepoImp(cartSourceData: gh<_i1050.CartSourceData>()),
    );
    gh.factory<_i592.DetailsProductSourceData>(
      () => _i592.DetailsProductSourceDataImp(),
    );
    gh.factory<_i147.AuthRemoteSourceData>(
      () => _i147.AuthRemoteSourceDataImp(),
    );
    gh.factory<_i1024.GetCartUseCase>(
      () => _i1024.GetCartUseCase(cartRepo: gh<_i113.CartRepo>()),
    );
    gh.factory<_i933.HomeRepo>(
      () => _i1026.HomeRepoImp(
        homeRemoteSourceData: gh<_i486.HomeRemoteSourceData>(),
      ),
    );
    gh.factory<_i467.DeleteItemCartUseCase>(
      () => _i467.DeleteItemCartUseCase(gh<_i113.CartRepo>()),
    );
    gh.factory<_i635.AuthRepo>(
      () => _i596.AuthRepoImp(gh<_i147.AuthRemoteSourceData>()),
    );
    gh.factory<_i698.DetailsProductRepo>(
      () => _i349.DetailsProductRepoImp(gh<_i592.DetailsProductSourceData>()),
    );
    gh.factory<_i979.GetCategoryUseCase>(
      () => _i979.GetCategoryUseCase(gh<_i933.HomeRepo>()),
    );
    gh.factory<_i969.GetProductByCateUseCase>(
      () => _i969.GetProductByCateUseCase(gh<_i933.HomeRepo>()),
    );
    gh.factory<_i107.GetProductUseCase>(
      () => _i107.GetProductUseCase(gh<_i933.HomeRepo>()),
    );
    gh.factory<_i324.ToggleFavoriteUseCase>(
      () => _i324.ToggleFavoriteUseCase(gh<_i933.HomeRepo>()),
    );
    gh.factory<_i914.AddToCartUseCase>(
      () => _i914.AddToCartUseCase(gh<_i698.DetailsProductRepo>()),
    );
    gh.factory<_i698.DetailsProductUseCase>(
      () => _i698.DetailsProductUseCase(gh<_i698.DetailsProductRepo>()),
    );
    gh.factory<_i494.GetOptionsUseCase>(
      () => _i494.GetOptionsUseCase(gh<_i698.DetailsProductRepo>()),
    );
    gh.factory<_i245.GetToppingUseCase>(
      () => _i245.GetToppingUseCase(gh<_i698.DetailsProductRepo>()),
    );
    gh.factory<_i908.GetProfileUseCase>(
      () => _i908.GetProfileUseCase(gh<_i635.AuthRepo>()),
    );
    gh.factory<_i1039.LoginUseCase>(
      () => _i1039.LoginUseCase(gh<_i635.AuthRepo>()),
    );
    gh.factory<_i994.LogoutUseCase>(
      () => _i994.LogoutUseCase(gh<_i635.AuthRepo>()),
    );
    gh.factory<_i701.SignupUseCase>(
      () => _i701.SignupUseCase(gh<_i635.AuthRepo>()),
    );
    gh.factory<_i190.UpdateProfileUseCase>(
      () => _i190.UpdateProfileUseCase(gh<_i635.AuthRepo>()),
    );
    gh.factory<_i152.HomeCubit>(
      () => _i152.HomeCubit(
        gh<_i979.GetCategoryUseCase>(),
        gh<_i107.GetProductUseCase>(),
        gh<_i324.ToggleFavoriteUseCase>(),
        gh<_i969.GetProductByCateUseCase>(),
      ),
    );
    gh.factory<_i428.AuthCubit>(
      () => _i428.AuthCubit(
        gh<_i1039.LoginUseCase>(),
        gh<_i701.SignupUseCase>(),
        gh<_i908.GetProfileUseCase>(),
        gh<_i994.LogoutUseCase>(),
        gh<_i190.UpdateProfileUseCase>(),
      ),
    );
    gh.factory<_i148.DetailsProductCubit>(
      () => _i148.DetailsProductCubit(
        gh<_i698.DetailsProductUseCase>(),
        gh<_i245.GetToppingUseCase>(),
        gh<_i494.GetOptionsUseCase>(),
        gh<_i914.AddToCartUseCase>(),
      ),
    );
    return this;
  }
}
