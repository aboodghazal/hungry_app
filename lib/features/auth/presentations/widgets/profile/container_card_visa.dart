import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/custom_text.dart';

class ContainerCardVisa extends StatelessWidget {
  const ContainerCardVisa({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.grey.shade900,
          Colors.grey.shade800,
          Colors.grey.shade900,
        ]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icon/profileVisa.png',
            width: 45,
            color: Colors.white,
          ),
          const Gap(20),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: const [
              CustomText(
                text: 'Debit card',
                color: Colors.white,
                size: 15,
              ),
              CustomText(
                text: '**** **** **** 9857',
                color: Colors.white,
                size: 14,
              )
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: CustomText(
              text: 'Default',
              color: Colors.grey.shade800,
              size: 14,
              weight: FontWeight.w500,
            ),
          ),
          const Gap(10),
          const Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
