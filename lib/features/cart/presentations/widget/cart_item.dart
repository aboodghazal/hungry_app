import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/cart/presentations/manager/cubit.dart';
import 'package:huungry/shared/image_widget.dart';
 import '../../../../core/themes/app_colors.dart';
import '../../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {

  const CartItem({
    super.key,

    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.cartEntity,
  });
   final CartEntity cartEntity;
  final Function() ? onAdd;
  final Function() ? onMin;
  final Function() ? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(image: cartEntity.image,width: 80,),
               //CustomText(text: cartEntity.,weight: FontWeight.bold, size: 14,),
              CustomText(text: cartEntity.itemId.toString(), size: 13,),
            ],
          ),

          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onAdd,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primary,
                      child: Icon(CupertinoIcons.add, color: Colors.white, size: 15),
                    ),
                  ),
                  Gap(20),
                  CustomText(text: cartEntity.quantity.toString() ,weight: FontWeight.w400,size: 20),
                  Gap(20),
                  GestureDetector(
                    onTap: onMin,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primary,
                      child: Icon(CupertinoIcons.minus, color: Colors.white, size: 15,),
                    ),
                  ),
                ],
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  CartCubit.get(context).deleteItemCart(cartEntity.itemId);
                },
                child: Container(
                  height: 40,
                  width:  130,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: CustomText(text: 'Remove',color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
