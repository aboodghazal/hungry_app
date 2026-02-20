import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
 import 'package:huungry/features/product/data/model/add_to_cart_model.dart';
import 'package:huungry/features/product/widgets/topping_card.dart';
import 'package:huungry/shared/custom_button.dart';
import 'package:huungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/global_model/product_model.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/error_state_widgets.dart';
import '../../../../shared/image_widget.dart';
import '../../../home/domain/entitys/product_entitys.dart';
import '../../data/model/topping_model.dart';
import '../../domain/entitys/topping_entitys.dart'; // لاستخدام ToppingEntity
import '../manager/cubit.dart';
import '../manager/state.dart';

 
 class ProductDetailsView extends StatefulWidget {
  final int productId; // 👈 تم إضافة الخاصية
  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  @override
  void initState() {
    super.initState();
    // 💡 تم نقل استدعاء loadAllData إلى GoRoute، لذا لا داعي لها هنا.
  }

  // دالة مساعدة لعملية إعادة المحاولة
  void _retryLoadData() {
    DetailsProductCubit.get(context).loadAllData(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsProductCubit, DetailsProductState>(
      listener: (context, state) {
        if(state is addToCartLoaded){
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<DetailsProductCubit, DetailsProductState>(
        buildWhen: (previous, current) => current is! ItemSelectionChanged && current is! ChangeSlider && current is! addToCartLoaded &&  current is! addToCartLoading,

        builder: (context, state) {


          if (state is DetailsProductLoading || state is DetailsProductInitial) {
            ProductEntity productData = ProductModel.empty().toEntity();

            return _buildContentDetailsProduct(
              context,
              product: productData,
              toppings: List.generate(5, (index) {
                return ToppingModel.empty().toEntity();
              },),
              options:  List.generate(5, (index) {
                return ToppingModel.empty().toEntity();
              },),
              loading: true,

            );
          } else if (state is DetailsProductLoaded) {
              return _buildContentDetailsProduct(
              context,
              product: state.product,
              toppings: state.toppings,
              options: state.options,
              loading: false,

            );
          } else if (state is DetailsProductError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0.0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              body: Center(
                child: ErrorStateWidget(
                  error: state.error,
                  function: _retryLoadData,
                ),
              ),
            );
          }else{
            return Container(
              color: Colors.red,
            );
          }

          // 🔹 استدعاء الدالة الموحدة اللي تبني كل التصميم

        },
      ),
    );
  }
}




Widget _buildContentDetailsProduct(
    BuildContext context, {
      required ProductEntity product,
      required List<ToppingEntity> toppings,
      required List<ToppingEntity> options,
      required bool loading,
     }) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔸 قسم تفاصيل المنتج الرئيسي (صورة + اسم + وصف + سلايدر + سعر)
            Skeletonizer(
              enabled: loading,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ImageWidget(
                      image: product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: product.name,
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        const Gap(8),
                        CustomText(
                          text: product.description,
                          size: 14,
                        ),
                        const Gap(16),
                        BlocBuilder<DetailsProductCubit, DetailsProductState>(
                          buildWhen: (previous, current) => current is ChangeSlider,
                          builder: (context, state) {
                            return Slider(
                              min: 0,
                              max: 1,
                              value: DetailsProductCubit.get(context).value,
                              onChanged: (value) => DetailsProductCubit.get(context).changeSliders(value),
                              inactiveColor: Colors.grey.shade300,
                              activeColor: AppColors.primary,
                            );
                          },

                        ),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: '🥶 ${product.price}', size: 14),
                            CustomText(text: '🌶️ ${product.rating}', size: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Gap(40),
            const CustomText(text: 'Toppings', size: 20),
            const Gap(50),

            // 🔸 قسم الـ Toppings
            Skeletonizer(
              enabled: loading,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    loading ? 3 : toppings.length,
                        (index) {
                      final topping = loading
                          ? ToppingModel.empty().toEntity()
                          : toppings[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SelectableToppingCard(
                          topping: topping,

                          cardType: SelectionType.topping, // ✅ تحديد النوع
                         ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const Gap(30),
            const CustomText(text: 'Side Options', size: 20),
            const Gap(50),

            // 🔸 قسم جانبي ثابت كمثال
            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SelectableToppingCard(
                      topping: options.isNotEmpty
                          ? options[index % options.length]
                          : ToppingModel.empty().toEntity(),
                      cardType: SelectionType.sideOption,



                     ),
                  );
                }),
              ),
            ),
            const Gap(100),
          ],
        ),
      ),
    ),

    // 🔸 أسفل الصفحة (bottomSheet)
    bottomSheet: Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
           children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(text: 'Total', size: 15),
                CustomText(text: '\$ ${product.price}', size: 24),
              ],
            ),
            Spacer(),
            BlocBuilder<DetailsProductCubit, DetailsProductState>(
              builder: (context, state) => state is addToCartLoading ?CircularProgressIndicator():CustomButton(text: 'Add To Cart', onTap: () {
                final cubitDetails = DetailsProductCubit.get(context);
                DetailsProductCubit.get(context).addToCart(AddToCartModel(productId: product.id, quantity: 1, spicy: cubitDetails.value.toString(), toppings: List.from(cubitDetails.selectedToppingIds), sideOptions: List.from(cubitDetails.selectedSideOptionIds)));
              },width: 120,),

            ),
          ],
        ),
      ),
    ),
  );
}

