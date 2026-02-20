import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huungry/core/global_model/product_model.dart';
import 'package:huungry/core/network/failure.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/product/data/model/add_to_cart_model.dart';
import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';
import 'package:huungry/features/product/domain/use_case/add_to_cart_use_case.dart';
import 'package:huungry/features/product/domain/use_case/details_product_use_case.dart';
import 'package:huungry/features/product/domain/use_case/get_options_use_case.dart';
import 'package:huungry/features/product/domain/use_case/get_topping_use_case.dart';
import 'package:huungry/features/product/presentations/manager/state.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailsProductCubit extends Cubit<DetailsProductState> {
  static DetailsProductCubit get(context) => BlocProvider.of(context);

  final DetailsProductUseCase detailsProductUseCase;
  final GetToppingUseCase getToppingUseCase;
  final GetOptionsUseCase getOptionsUseCase;
  final AddToCartUseCase addToCartUseCase;
  ProductEntity productEntity = ProductModel.empty().toEntity();

  List<int> selectedToppingIds = [];
  List<int> selectedSideOptionIds = [];
  double value = 0.5;


  DetailsProductCubit(this.detailsProductUseCase, this.getToppingUseCase, this.getOptionsUseCase, this.addToCartUseCase) : super(DetailsProductInitial());


  Future<void> loadAllData(int idProduct) async {
    emit(DetailsProductLoading());


      // 1. تنفيذ جميع الطلبات بشكل متوازٍ
      final results = await Future.wait<Either<dynamic, dynamic>>([
        detailsProductUseCase.call(idProduct), // الطلب 1: المنتج الرئيسي
        getToppingUseCase.call(),             // الطلب 2: المنتجات ذات الصلة/الإضافات (يجب أن يعيد قائمة)
        getOptionsUseCase.call(),
      ]);

      final productResult = results[0] as Either<ServerFailure, ProductEntity>;
      final relatedProductsResult = results[1] as Either<ServerFailure, ToppingResponseEntity>; // نفترض أنه يعيد قائمة
    final resultOptions = results[2] as Either<ServerFailure,ToppingResponseEntity>;

      // 2. معالجة نتائج المنتج الرئيسي (الطلب الأهم)
      productResult.fold(
            (failure) {
          // إذا فشل المنتج الرئيسي: نُصدر خطأ للصفحة بأكملها
          emit(DetailsProductError(failure.message));
        },
            (product) {
          // إذا نجح المنتج الرئيسي: نستخرج نتائج الطلبات الفرعية

          final relatedProducts = relatedProductsResult.getOrElse(() {
            // في حال فشل تحميل الإضافات، نمرر قائمة فارغة
            // يمكن تسجيل الخطأ هنا (logging)
            return ToppingResponseEntity([]);


          });

          final options = resultOptions.getOrElse(() {
            return ToppingResponseEntity([]);
          },);

          // 3. إصدار حالة النجاح الموحدة
          this.productEntity = product; // تحديث الكائن المحلي
          emit(DetailsProductLoaded(
            product: product,
            toppings:  relatedProducts.listTopping,
            options: options.listTopping,
          ));
        },
      );
    }


      Future<void> addToCart(AddToCartModel cartItem)async{
        emit(addToCartLoading());
        final result = await addToCartUseCase.call(cartItem);
        result.fold((l) {
          emit(DetailsProductError(l.message));
        }, (r) {
          emit(addToCartLoaded(r));
        },);

      }

      void changeSliders(double value){
        this.value = value;
        emit(ChangeSlider(value));

      }
  void toggleTopping(int toppingId) {
    if (selectedToppingIds.contains(toppingId)) {
      selectedToppingIds.remove(toppingId);
    } else {
      selectedToppingIds.add(toppingId);
    }
    emit(ItemSelectionChanged(toppingId,SelectionType.topping)); // حالة خاصة لهذا التوبينج فقط
  }

// 🔹 اختيار أو إزالة Side Option
  void toggleSideOption(int optionId) {
    if (selectedSideOptionIds.contains(optionId)) {
      selectedSideOptionIds.remove(optionId);
    } else {
      selectedSideOptionIds.add(optionId);
    }
    emit(ItemSelectionChanged(optionId,SelectionType.sideOption)); // حالة خاصة لهذا التوبينج فقط
  }

}


// 🔹 اختيار أو إزالة Topping

/*
  Future<void> getProduct(int idProduct) async {
     emit(DetailsProductLoading());


       final result = await detailsProductUseCase.call(idProduct);

      result.fold(
            (l) {
           emit(DetailsProductError(l.message));
        },
            (product) {
           productEntity = product;
          emit(DetailsProductLoaded(product: product));
        },
      );

  }
  Future<void> getTopping() async {
     emit(DetailsProductLoading());


       final result = await getToppingUseCase.call();

      result.fold(
            (l) {
           emit(DetailsProductError(l.message));
        },
            (product) {
           productEntity = product;
          emit(DetailsProductLoaded(product: product));
        },
      );

  }*/

