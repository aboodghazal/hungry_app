import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../shared/custom_text.dart';

class ButtonEditProfile extends StatelessWidget {
   final GestureTapCallback? onTap;
   final bool isLoading;

  const ButtonEditProfile({super.key, this.onTap,this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: isLoading ? CupertinoActivityIndicator(
              color: Colors.white,
            ):  CustomText(
              text: 'Edit Profile',
              color: Colors.white,
              size: 15,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
