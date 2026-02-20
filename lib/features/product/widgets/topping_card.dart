import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/themes/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/image_widget.dart';
import '../domain/entitys/topping_entitys.dart';
import '../presentations/manager/cubit.dart';
import '../presentations/manager/state.dart';


class SelectableToppingCard extends StatelessWidget {
  final ToppingEntity topping;
  final SelectionType cardType;

  const SelectableToppingCard({
    super.key,
    required this.topping,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsProductCubit, DetailsProductState>(
      // ✅ فقط نعيد البناء لما العنصر نفسه يتغير
      buildWhen: (previous, current) {
        if (current is ItemSelectionChanged) {
          return current.selectionType == cardType &&
              current.itemId == topping.id;
        }
        return false;
      },
      builder: (context, state) {
        final cubit = DetailsProductCubit.get(context);

        final bool isSelected = cardType == SelectionType.topping
            ? cubit.selectedToppingIds.contains(topping.id)
            : cubit.selectedSideOptionIds.contains(topping.id);

        return GestureDetector(
          onTap: () {
            if (cardType == SelectionType.topping) {
              cubit.toggleTopping(topping.id);
            } else {
              cubit.toggleSideOption(topping.id);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 90,
                  width: 90,
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                top: -40,
                right: -1,
                left: -1,
                child: SizedBox(
                  height: 70,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: ImageWidget(image: topping.image, fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CustomText(
                        text: topping.name,
                        color: Colors.white,
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                      const Gap(5),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          isSelected ? Icons.check : Icons.add,
                          color: isSelected ? Colors.green : Colors.red,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
