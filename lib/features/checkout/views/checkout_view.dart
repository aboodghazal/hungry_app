import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
 import 'package:huungry/features/home/presentations/manager/cubit.dart';
import 'package:huungry/shared/custom_text.dart';

import '../../../core/themes/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../widgets/order_details_widget.dart';


class CheckoutView extends StatefulWidget {
  final String priceOrder;
  const CheckoutView({super.key,required this.priceOrder});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
    double orderPrice = 0.0;
    double taxes = 0.0;
    double fees = 0.0;
    double total = 0.0;


  @override
  void initState() {
    super.initState();

    orderPrice = double.tryParse(widget.priceOrder) ?? 0.0;
    taxes = 3.50;
    fees = 40.33;

    total = orderPrice + taxes + fees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomText(text: 'Order summary', size: 20, weight: FontWeight.w500),
              const Gap(10),
              OrderDetailsWidget(
                order: orderPrice.toStringAsFixed(2),
                taxes: taxes.toStringAsFixed(2),
                fees: fees.toStringAsFixed(2),
                total: total.toStringAsFixed(2),
              ),


              const Gap(40),

              const CustomText(text: 'Payment methods', size: 20, weight: FontWeight.w500),
              const Gap(15),

              // ---------------- CASH ----------------
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: const Color(0xff3C2F2F),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: Image.asset('assets/icon/cash.png', width: 50),
                title: const CustomText(text: 'Cash on Delivery', color: Colors.white),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selectedMethod,
                  onChanged: (v) => setState(() => selectedMethod = v!),
                ),
                onTap: () => setState(() => selectedMethod = 'Cash'),
              ),

              const Gap(10),

              // ---------------- DEBIT CARD ----------------
              if(HomeCubit.get(context).userEntity.visa != '')
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.blue.shade900,
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: const Icon(CupertinoIcons.creditcard, color: Colors.white),
                title: const CustomText(text: 'Debit card', color: Colors.white),
                subtitle:  CustomText(text: '${HomeCubit.get(context).userEntity.visa}', color: Colors.white),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selectedMethod,
                  onChanged: (v) => setState(() => selectedMethod = v!),
                ),
                onTap: () => setState(() => selectedMethod = 'Visa'),
              ),

              const Gap(5),

              // ---------------- SAVE CARD CHECKBOX ----------------
              Row(
                children: const [
                  Checkbox(
                    activeColor: Color(0xffEF2A39),
                    value: true,
                    onChanged: null,
                  ),
                  CustomText(text: 'Save card details for future payments'),
                ],
              ),

              const Gap(150),
            ],
          ),
        ),
      ),

      // ---------------- BOTTOM PAY SECTION ----------------
      bottomSheet: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // TOTAL SECTION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CustomText(text: 'Total', size: 15),
                  CustomText(      text: '\$ ${total.toStringAsFixed(2)}',
                      size: 24, weight: FontWeight.bold),
                ],
              ),

              // PAY BUTTON
              CustomButton(
                text: 'Pay Now',

                width: 100,


                onTap: () {
                  showDialog(
                    context: context,

                    builder: (context) {
                      return Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 260,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 15,
                                ),
                              ],
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primary,
                                  child: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),

                                const Gap(10),

                                CustomText(
                                  text: 'Success!',
                                  weight: FontWeight.bold,
                                  color: AppColors.primary,
                                  size: 20,
                                ),

                                const Gap(5),

                                CustomText(
                                  text: 'Your payment was successful.\nA receipt was sent to your email.',
                                  color: Colors.grey,
                                  size: 12,

                                 ),

                                const Gap(15),

                                CustomButton(
                                  text: 'Close',
                                  width: 120,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
