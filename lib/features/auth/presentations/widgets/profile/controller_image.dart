import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/global_bloc/image/image_cubit.dart';
import '../../../../../shared/custom_text.dart';

class ControllerImage extends StatelessWidget {
  const ControllerImage({super.key});

  @override
  Widget build(BuildContext context) {
    final img = ImageCubit.get(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => img.getImage(),
          child: Card(
            elevation: 1,
            color: Colors.blue.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text:
                        img.imageProfile == null
                            ? 'Upload Image'
                            : 'Change Image',
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  const Gap(6),
                  const Icon(
                    CupertinoIcons.camera,
                    size: 17,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(10),
        GestureDetector(
          onTap: () => img.clearImage(),
          child: Card(
            elevation: 1,
            color: Colors.red.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'Remove Image',
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  Gap(6),
                  Icon(CupertinoIcons.trash, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    ;
  }
}
