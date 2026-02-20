import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:huungry/features/auth/domain/entity/user_entity.dart';
import 'package:huungry/features/auth/domain/usescase/get_profile_use_case.dart';
import 'package:huungry/features/auth/domain/usescase/login_use_case.dart';
import 'package:huungry/features/auth/domain/usescase/logout_use_case.dart';
import 'package:huungry/features/auth/domain/usescase/signup_use_case.dart';
import 'package:huungry/features/auth/domain/usescase/update_profile_use_case.dart';
import 'package:huungry/features/auth/presentations/manager/login/state.dart';
import 'package:injectable/injectable.dart';

  @injectable
class AuthCubit extends Cubit<AuthState> {

    static AuthCubit get(context) => BlocProvider.of(context);

    final LoginUseCase loginUseCase;
    final SignupUseCase signupUseCase;
    final GetProfileUseCase getProfileUseCase;
    final LogoutUseCase logoutUseCase;
    final UpdateProfileUseCase updateProfileUseCase;

    UserEntity userEntity = UserModel.emptyOne().toEntity();

  AuthCubit(this.loginUseCase, this.signupUseCase, this.getProfileUseCase, this.logoutUseCase, this.updateProfileUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

     final result = await loginUseCase.call(email, password);

      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) => emit(AuthSuccess(user)),
      );

  }

    Future<void> signUp(String name ,String email, String password) async {
      emit(AuthLoading());

      final result = await signupUseCase.call(name,email, password);

      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) => emit(AuthSuccess(user)),
      );

    }

    Future<void> getDataProfile() async {
      emit(AuthLoading());

      final result = await getProfileUseCase.call();

      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              userEntity = user;

              print('${user.name} _+_+++_+_+__++_+__+_+_+__++___');
              print('${userEntity.email} _+_+++_+_+__++_+__+_+_+__++___');

               emit(AuthSuccess(user));
            } ,
      );

    }


    Future<void> logout() async {
      emit(LogoutLoading());

      final result = await logoutUseCase.call();

      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (message) => emit(LogoutSuccess(message)),
      );

    }

    Future<void> updateProfileUser(UserModel user) async {
      emit(UpdateProfileLoading());

      final result = await updateProfileUseCase.call(user);

      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (message) => emit(UpdateProfileSuccess(message)),
      );

    }
}
