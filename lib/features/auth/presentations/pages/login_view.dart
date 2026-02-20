import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/cached/app_controller.dart';
import 'package:huungry/core/routes/routes.dart';
import 'package:huungry/core/themes/app_colors.dart';
import 'package:huungry/core/themes/dimintions.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart';
import 'package:huungry/features/auth/presentations/manager/login/state.dart';
 import 'package:huungry/shared/custom_snack.dart';
import 'package:huungry/shared/custom_text.dart';
import 'package:huungry/shared/custom_txtfield.dart';
import 'package:huungry/shared/glass_container.dart';
import 'package:huungry/shared/horizontal_sized_box.dart';
import 'package:huungry/shared/vertical_sized_box.dart';

import '../../../../core/assets/assets.gen.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
  //  emailController.text = 'Sonic3@gmail.com';
    passController.text = '123456789';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
           context.replaceNamed(Routes.ROOT);

        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnack(state.error));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const  VerticalSizedBox(100),
                  Assets.logo.logo.svg(color: AppColors.primary),


                 const  VerticalSizedBox(vBetweenItem),
                  CustomText(
                    text: 'Welcome Back, Discover The Fast Food',
                    color: AppColors.primary,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                 const  VerticalSizedBox(50),


                  glassContainer(
                    child: Column(
                      children: [
                        const VerticalSizedBox(vMedium30),

                        CustomTxtfield(
                          controller: emailController,
                          hint: 'Email Address',
                          isPassword: false,
                        ),
                        const VerticalSizedBox(vSmall),

                        CustomTxtfield(
                          controller: passController,
                          hint: 'Password',
                          isPassword: true,
                        ),
                        const VerticalSizedBox(vBetweenItem),

                        /// زر تسجيل الدخول مع BlocBuilder
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;

                            return isLoading
                                ? CupertinoActivityIndicator(
                              color: AppColors.primary,
                            )
                                : CustomAuthBtn(
                              text: 'Login',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).login(
                                    emailController.text.trim(),
                                    passController.text.trim(),
                                  );
                                }
                              },
                              color: AppColors.primary,
                              textColor: Colors.white,
                            );
                          },
                        ),

                        const VerticalSizedBox(vSmall),
                        Row(
                          children: [
                            /// Signup
                            Expanded(
                              child: CustomAuthBtn(
                                color: Colors.white,
                                textColor: AppColors.primary,
                                text: 'Signup',
                                onTap: () {
                                  context.replaceNamed(Routes.SIGNUP);

                                },
                              ),
                            ),
                            const HorizontalSizedBox(hSmall),
                            /// Guest
                            Expanded(
                              child: CustomAuthBtn(
                                color: Colors.white,
                                textColor: AppColors.primary,
                                text: 'Guest',
                                onTap: () {
                                  context.goNamed(Routes.ROOT);


                                },
                              ),
                            ),
                          ],
                        ),
                        const VerticalSizedBox(vSmall),
                      ],
                    ),
                  ),
                  const VerticalSizedBox(150),

                  CustomText(
                    text: '@AboodGhazal2003',
                    color: AppColors.primary,
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
