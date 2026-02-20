import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:huungry/core/themes/app_padding.dart';
import 'package:huungry/core/themes/app_radius.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/home/presentations/manager/cubit.dart';
import 'package:huungry/shared/image_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  final ProductEntity productEntity;
  final bool isLoading;

  const CardItem({
    super.key,
    required this.productEntity,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.largeRadius,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: AppPadding.smallPadding,
          child: isLoading
              ? _buildSkeletonLoader() // 🟢 حالة التحميل
              : _buildContent(context), // 🟢 الحالة العادية
        ),
      ),
    );
  }

  /// 💨 تصميم حالة التحميل




  Widget _buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: AppColors.greyTextColor.withOpacity(0.6), // لون أغمق شوي للقاعدة
      highlightColor: AppColors.greyTextColor.withOpacity(0.35), // وميض أوضح
      period: const Duration(milliseconds: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          // 🔹 صورة المنتج
          Container(
            height: 80.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.4), // درجة أوضح
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const Gap(15),
          // 🔹 اسم المنتج
          Container(
            height: 12,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.45),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          // 🔹 وصف المنتج
          Container(
            height: 10,
            width: 150,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(15),
          // 🔹 تقييم المنتج
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const Gap(8),
              Container(
                height: 10,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 💎 التصميم الحقيقي بعد التحميل
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -15.h,
              right: 10.w,
              left: 10.w,
              child:
              Image.asset('assets/icon/shadow.png', color: Colors.black26),
            ),
            Center(
              child: ImageWidget(
                image: productEntity.image,
                height: 80.h,
                width: 120.w,
                showLoader: true,

               ),
            ),
          ],
        ),
        const Gap(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: productEntity.name,
                weight: FontWeight.bold,
                size: 13,
                color: Colors.white,
              ),
              CustomText(
                text: productEntity.description,
                size: 14,
                color: Colors.white,
              ),
              const Gap(10),
              Row(
                children: [
                  const Icon(CupertinoIcons.star_fill,
                      size: 16, color: Colors.white),
                  CustomText(
                    text: productEntity.rating,
                    size: 15,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      productEntity.isFavorite = !productEntity.isFavorite;
                      (context as Element).markNeedsBuild();
                      HomeCubit.get(context).toggleFav(productEntity.id);
                    },
                    child: Icon(
                      CupertinoIcons.heart,
                      color: productEntity.isFavorite
                          ? Colors.red
                          : Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
