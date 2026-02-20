import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/themes/app_colors.dart';
import 'package:huungry/core/themes/dimintions.dart';
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart'; // AuthCubit
import 'package:huungry/features/auth/presentations/manager/login/state.dart';
 import 'package:huungry/shared/custom_snack.dart';
import 'package:huungry/shared/custom_text.dart';
import 'package:huungry/shared/custom_txtfield.dart';
import 'package:huungry/shared/glass_container.dart';
import 'package:huungry/shared/horizontal_sized_box.dart';
import '../../../../core/routes/routes.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../widgets/custom_btn.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnack(state.error
          ));
        } else if (state is AuthSuccess) {
          context.replaceNamed(Routes.LOGIN);

        }
      },
      child: PopScope(
        canPop: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white),
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const VerticalSizedBox(100),
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      color: AppColors.primary,
                    ),
                    const VerticalSizedBox(vSmall),
                    Center(
                      child: CustomText(
                        text: 'Welcome to our Food App',
                        color: AppColors.primary,
                      ),
                    ),
                    const VerticalSizedBox(vLarge),

                    /// Container
                    glassContainer(
                      child: Column(
                        children: [
                          const VerticalSizedBox(vMedium30),
                          CustomTxtfield(
                            controller: nameController,
                            hint: 'Name',
                            isPassword: false,
                          ),
                          const VerticalSizedBox(vSmall),
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
                          const VerticalSizedBox(vMedium20),

                          /// BlocBuilder فقط على الزر
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CupertinoActivityIndicator();
                              }

                              return CustomAuthBtn(
                                color: AppColors.primary,
                                textColor: Colors.white,
                                text: 'Sign up',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).signUp(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      passController.text.trim(),
                                    );
                                  }
                                },
                              );
                            },
                          ),

                          const VerticalSizedBox(vSmall),
                          Row(
                            children: [
                              /// Login
                              Expanded(
                                child: CustomAuthBtn(
                                  textColor: AppColors.primary,
                                  color: Colors.white,
                                  text: 'Login',
                                  onTap: () {
                                    context.replaceNamed(Routes.LOGIN);

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
                    const VerticalSizedBox(110),
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
      ),
    );
  }
}
