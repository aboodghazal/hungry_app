import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/themes/app_radius.dart';
import 'package:huungry/features/home/presentations/manager/cubit.dart';
import 'package:huungry/features/home/presentations/manager/state.dart';
import 'package:huungry/shared/image_widget.dart';
import '../../../../core/cached/app_controller.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/custom_text.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}



class _UserHeaderState extends State<UserHeader> {
  
  @override
  void initState() {
     HomeCubit.get(context).getUserData();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
 
     return BlocBuilder<HomeCubit,HomeState>(
      buildWhen: (previous, current) => current is UserLoaded,
      builder: (context, state) {
        final user = HomeCubit.get(context).userEntity;
         return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'Hello,',
                      size: 30.sp,
                      weight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                    CustomText(
                      text: user.name,
                      size: 30.sp,
                      weight: FontWeight.w200,
                      color: AppColors.primary,
                    ),

                  ],
                ),
                // SvgPicture.asset(
                //     'assets/logo/logo.svg',
                //     color: AppColors.primary,
                //     height: 28,
                // ),
                CustomText(
                  text: 'Hungry Today?',
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.primary,
              child: ClipRRect(
                borderRadius: AppRadius.largeRadius,
                child: ImageWidget(image: user.image),
              ),
            ),
          ],
        );
      },

    );
  }
}
