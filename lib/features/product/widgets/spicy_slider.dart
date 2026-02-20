
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/themes/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/image_widget.dart';
import '../../home/domain/entitys/product_entitys.dart';

Widget buildContentDetailsProduct(
    BuildContext context,
    {
      required ProductEntity data,
      required bool loading,
    }
    ){

  return Skeletonizer(
    enabled: loading,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the top
      children: [
        // 1. Image Widget with fixed height, but responsive width (or constrain manually)
        // Consider giving the image a specific size, or making it flexible.
        // For now, let's give it a reasonable fixed size for the "detail" view.
        // Or, use a Flexible/Expanded for the image if it should take remaining space.
        // For an image that's part of a detail header, a fixed height often works.
        SizedBox(
          width: 150, // Example fixed width, adjust as needed
          height: 150, // Example fixed height
          child: ImageWidget(
            image: data.image,

          ),
        ),

        Gap(16), // A consistent gap between image and text content

        // 2. Main Text Content: Use Expanded to take remaining horizontal space
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            children: [
              // Product Name/Title - Ensure it wraps if long
              CustomText(
                text: data.name,
                size: 20,
                weight: FontWeight.bold,

              ),
              Gap(8),
              // Description - Ensure it wraps if long
              CustomText(
                text: data.description,
                size: 14,

              ),
              Gap(16),

              // 3. Slider: This widget needs all available horizontal space to look good
              // No need to wrap Slider in Expanded if its parent (Column) is already Expanded
              Slider(
                min: 0,
                max: 1,
                value: 0.5, // Use the widget's value
                onChanged: (value) {

                }, // Use the widget's onChanged
                inactiveColor: Colors.grey.shade300,
                activeColor: AppColors.primary,
              ),
              Gap(8),

              // 4. Rating Row: Use Spacer for flexible spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between items
                children: [
                  CustomText(text: '🥶 ${data.name}'), // Maybe dynamic based on slider value?
                  // Gap(50) is replaced by Spacer and mainAxisAlignment.spaceBetween
                  CustomText(text: '🌶️ ${data.rating}'), // This is fine
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
