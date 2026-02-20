import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/routes/routes.dart';
import 'package:huungry/features/cart/data/model/cart_model.dart';
import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/cart/presentations/manager/cubit.dart';
import 'package:huungry/features/cart/presentations/manager/state.dart';
 import 'package:huungry/features/cart/presentations/widget/cart_item.dart';
import 'package:huungry/features/checkout/views/checkout_view.dart';
import 'package:huungry/shared/custom_text.dart';
import 'package:huungry/shared/error_state_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../shared/custom_button.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 9;
  late List<int> quantities;

  @override
  void initState() {
    quantities = List.generate(itemCount, (_) => 1);
    super.initState();
  }
  void onAdd (int index) {
    setState(() {
      quantities[index]++;
    });
  }
  void onMin(int index) {
    setState(() {
      if(quantities[index] > 1)
        {
          quantities[index]--;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: CustomText(
          text:  'My Cart',
          color: Colors.black87,
          weight: FontWeight.w600,
          size: 20,
        ),
      ),
      body:BlocBuilder<CartCubit,CartState>(builder: (context, state) {
        if(state is CartError){
          return Center(child: ErrorStateWidget(error: state.message, function: (){}),);
        }else if(state is CartLoaded){
          return buildContentCart(context, listData: state.cartDetails.items, price: state.cartDetails.totalPrice, loading: false);
        }else{
          return buildContentCart(context, listData:List.generate(5, (index) {
            return CartItemModel.empty().toEntity();
          },), price: '0', loading: true);

        }

      },)
    );
  }

  Widget buildContentCart(BuildContext context,{
    required List<CartEntity> listData,
    required String price,
   required bool loading ,

  }){
    return Skeletonizer(
      enabled: loading,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(bottom: 140, top: 10),
              itemCount: listData.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: CartItem(
                       cartEntity: listData[index],
                      onAdd: () => onAdd(index),
                      onMin: () => onMin(index),
                    ),
                  ),
                );
              },
            ),
          ),

          // Floating total bar
          Positioned(
            right: -10,
            left: -10,
            bottom:-10,

            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.9),
                //     blurRadius: 3,
                //     offset: const Offset(2, 3),
                //   ),
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.9),
                //     blurRadius: 800,
                //     offset: const Offset(300, 50),
                //   ),
                // ],
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Gap(8),
                  GestureDetector(
                      onTap: () => context.push(Routes.checkOut,extra: price
                      ),
                      child: CustomButton(
                        height: 45,
                        text: 'Checkout',
                        gap: 180,
                        widget: CustomText(text: '$price\$', size: 14),
                        color: Colors.white,
                        width: double.infinity,
                        textColor: Colors.black,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
