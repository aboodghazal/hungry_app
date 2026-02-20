import 'package:dartz/dartz.dart';
import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/repository/home_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';

@injectable
class ToggleFavoriteUseCase {
  HomeRepo homeRepo;
  ToggleFavoriteUseCase(this.homeRepo);

  Future<Either<ServerFailure, String>> call(int idProduct){
    return homeRepo.toggleFavorite(idProduct);
  }
}