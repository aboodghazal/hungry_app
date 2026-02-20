
import '../../domain/entity/cart_entity.dart';

sealed class CartState {}

 class CartInitial extends CartState {}

 class CartLoading extends CartState {}

 class CartLoaded extends CartState {
   final CartResponseEntity cartDetails;

  CartLoaded({required this.cartDetails});
}


/*class CartItemUpdating extends CartState {
  final int itemId;
  final int newQuantity;

  CartItemUpdating({required this.itemId, required this.newQuantity});
}*/

 class CartError extends CartState {
  final String message;

  CartError({required this.message});
}