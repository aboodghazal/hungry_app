 import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';



abstract class DetailsProductState {}

class DetailsProductInitial extends DetailsProductState {}

class DetailsProductLoading extends DetailsProductState {}



class DetailsProductLoaded extends DetailsProductState{
  final ProductEntity product;
  final List<ToppingEntity> toppings;
  final List<ToppingEntity> options;


  DetailsProductLoaded({required this.product,this.toppings = const [],this.options = const[]});
}

class DetailsProductError extends DetailsProductState{
  final String error;
  DetailsProductError(this.error);
}


class addToCartLoading extends DetailsProductState {}
class addToCartLoaded extends DetailsProductState {
 final String success;

  addToCartLoaded(this.success);
}

class ChangeSlider extends DetailsProductState{
  final double value;

  ChangeSlider(this.value);
}
 enum SelectionType { topping, sideOption }

 class ItemSelectionChanged extends DetailsProductState {
   final int itemId;
   final SelectionType selectionType;

   ItemSelectionChanged(this.itemId, this.selectionType);
 }

