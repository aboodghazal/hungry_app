import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huungry/core/cached/app_controller.dart';
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart';
import 'package:huungry/features/auth/presentations/manager/login/state.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../shared/custom_text.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return                           Expanded(
      child: GestureDetector(
        onTap: () {
          AppController.instance.logout(context);
         },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border:
            Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child:
            BlocBuilder<AuthCubit,AuthState>(
              buildWhen: (previous, current) => current is LogoutSuccess || current is LogoutLoading,
              builder: (context, state) {
                return state is LogoutLoading ?CupertinoActivityIndicator(
                  color: AppColors.primary,
                ) : CustomText(
                  text: 'Logout',
                  color: AppColors.primary,
                  size: 15,
                  weight: FontWeight.w600,
                );
              },
             ),
          ),
        ),
      ),
    );

  }
}
