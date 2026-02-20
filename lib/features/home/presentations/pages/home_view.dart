import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/routes/routes.dart';
import 'package:huungry/core/themes/app_padding.dart';
import 'package:huungry/core/themes/app_radius.dart';
import 'package:huungry/core/themes/dimintions.dart';
import 'package:huungry/features/home/data/models/category_model.dart';
 import 'package:huungry/features/home/domain/entitys/category_entity.dart';
import 'package:huungry/features/home/domain/entitys/product_entitys.dart';
import 'package:huungry/features/home/presentations/manager/cubit.dart';
import 'package:huungry/features/home/presentations/manager/state.dart';
 import 'package:huungry/shared/error_state_widgets.dart';
import 'package:huungry/shared/vertical_sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/global_model/product_model.dart';
import '../../../../shared/empty_widget.dart';
import '../widgets/card_item.dart';
import '../widgets/food_catrgory.dart';
import '../widgets/search_field.dart';
import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = -1;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [

            /// 🧩 Header
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: false,
              toolbarHeight: 180.h,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: ClipRRect(
                borderRadius:AppRadius.largeRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 500),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(450).withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: AppPadding.horizontalAndVertical.copyWith(
                        top: 60.h
                      ),
                      child: Column(
                        children: [
                          const UserHeader(),
                          const VerticalSizedBox(vMedium20),
                          SearchField(
                            searchController:textEditingController ,
                            onChanged: (value) {
                              homeCubit.searchData(value);

                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// 🟢 Category Section
            SliverToBoxAdapter(
              child: Padding(
                padding:AppPadding.horizontalAndVertical.copyWith(
                  top: 20
                ),
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, c) =>
                  c is CateLoading || c is CateLoaded || c is CateError,
                  builder: (context, state) {
                    if (state is CateLoaded) {
                      return _buildContentCate(
                        context,
                        list: homeCubit.categories.listCate,
                        loading: false,
                      );
                    } else if (state is CateError) {
                      return Center(
                        child: ErrorStateWidget(
                          error: '⚠️ فشل تحميل التصنيفات',
                          function: () {
                            homeCubit.getCategory();
                          },
                        ),
                      );
                    } else {
                      return _buildContentCate(
                        context,
                        list: List.generate(
                          6,
                              (_) => CategoryModel.empty().toEntity(),
                        ),
                        loading: true,
                      );
                    }
                  },
                ),
              ),
            ),

            /// 🟠 Products Section
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (p, c) =>
              c is ProductLoading || c is ProductLoaded || c is ProductError,
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return _buildContentProduct(
                    context,
                    list: state.products,
                    loading: false,
                  );
                } else if (state is ProductError) {
                  return Center(
                    child: ErrorStateWidget(
                      error: '⚠️ فشل تحميل المنتجات ',
                      function: () {},
                    ),
                  );
                } else {
                  return _buildContentProduct(
                    context,
                    list: List.generate(
                      6,
                          (_) => ProductModel.empty().toEntity(),
                    ),
                    loading: true,
                  );
                }





              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🟢 Category Builder
  Widget _buildContentCate(BuildContext context, {
    required List<CategoryEntity> list,
    required bool loading,
  }) =>
      Skeletonizer(
        enabled: loading,
        child: list.isEmpty
            ? Center(child: const EmptyWidget(label: 'No Categories Found'))
            : FoodCategory(
          selectedIndex: selectedIndex,
          category: list,
        ),
      );


  Widget _buildContentProduct(BuildContext context, {
    required List<ProductEntity> list,
    required bool loading,
  }) {
    if (list.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: const EmptyWidget(label: 'No Product Found')),
      );
    }

    return SliverPadding(
      padding:AppPadding.horizontalAndVertical,
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => GestureDetector(
                onTap: () => context.pushNamed(Routes.DETAILS_PRODUCTS,extra: list[index].id),
                child: CardItem(productEntity: list[index],isLoading: loading,),
              ),
          childCount: list.length,
        ),
      ),
    );
  }


}