


import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';

import '../../../auth/domain/entity/user_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CateLoading extends HomeState {}



class CateLoaded extends HomeState{
  final List<CategoryEntity> listCate;

  CateLoaded({required this.listCate});
}

class CateError extends HomeState{
  final String error;
  CateError(this.error);
}


class ProductLoading extends HomeState {}

class ProductLoaded extends HomeState{
  final List<ProductEntity> products;

  ProductLoaded({required this.products});
}



class ProductError extends HomeState {
  final String error;
  ProductError(this.error);
}

class UserLoaded extends HomeState {
  final UserEntity user;
  UserLoaded(this.user);
}
