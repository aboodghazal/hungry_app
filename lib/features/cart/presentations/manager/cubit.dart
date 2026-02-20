import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/cart/domain/use_case/delete_item_cart_use_case.dart';
import 'package:huungry/features/cart/domain/use_case/get_cart_use_case.dart';
import 'package:huungry/features/cart/presentations/manager/state.dart';

class CartCubit extends Cubit<CartState>{

  static CartCubit get(context)=>BlocProvider.of(context);

  final GetCartUseCase getCartUseCase;
  final DeleteItemCartUseCase deleteItemCartUseCase;
  CartResponseEntity cartResponseEntity = CartResponseModel.empty().toEntity();

  CartCubit(this.getCartUseCase, this.deleteItemCartUseCase):super(CartInitial());


  Future<void> getCart()async{
    emit(CartLoading());
    final result = await getCartUseCase.call();
    result.fold((l) => emit(CartError(message: l.message)), (data) {
      cartResponseEntity = data;
      emit(CartLoaded(cartDetails: data));
    },);
  }

  Future<void> deleteItemCart(int idItem)async{
    cartResponseEntity.items.removeWhere((element) => element.itemId == idItem);

    emit(CartLoaded(cartDetails: cartResponseEntity));
        final result = await deleteItemCartUseCase.call(idItem);
    result.fold((l) {
      getCart();
      emit(CartError(message: l.message));
    }, (data) {
      emit(CartLoaded(cartDetails: cartResponseEntity));

    },);
  }

}