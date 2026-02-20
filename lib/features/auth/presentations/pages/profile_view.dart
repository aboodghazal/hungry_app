import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/global_bloc/image/image_cubit.dart';
import 'package:huungry/core/global_bloc/image/image_state.dart';
import 'package:huungry/core/routes/routes.dart';
import 'package:huungry/core/themes/app_padding.dart';
import 'package:huungry/core/themes/dimintions.dart';
import 'package:huungry/features/auth/data/models/user_model.dart';
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart';
import 'package:huungry/features/auth/presentations/manager/login/state.dart';
 import 'package:huungry/features/auth/presentations/widgets/profile/button_edit_profile.dart';
import 'package:huungry/features/auth/presentations/widgets/profile/button_logout.dart';
import 'package:huungry/features/auth/presentations/widgets/profile/container_card_visa.dart';
import 'package:huungry/features/auth/presentations/widgets/profile/controller_image.dart';
import 'package:huungry/features/auth/presentations/widgets/profile/image_profile_user.dart';
import 'package:huungry/shared/horizontal_sized_box.dart';
import 'package:huungry/shared/vertical_sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_user_txt_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// تحميل بيانات البروفايل من AuthCubit
    AuthCubit.get(context).getDataProfile().then((_) {
      final user = AuthCubit.get(context).userEntity;
      _name.text = user.name;
      _email.text = user.email;
      _address.text = user.address!.isEmpty ? "55 Dubai, UAE" : user.address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthCubit.get(context);
    final img = ImageCubit.get(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding:AppPadding.horizontal,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: BlocListener<AuthCubit,AuthState>(
              listener: (context, state) {
                if(state is LogoutSuccess){
                  context.goNamed(Routes.LOGIN);
                 }
              },
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: auth.userEntity.name.isEmpty || auth.userEntity.image.isEmpty,
                    child: Column(
                      children: [
                        const VerticalSizedBox(50),


                        /// ===== صورة الملف الشخصي =====
                        BlocBuilder<ImageCubit, ImageState>(
                          buildWhen: (previous, current) => current is ImageChangeState || current is ImageChangeFilerState,
                          builder: (context, state) {
                            Widget imageWidget;

                            // الحالة 1: المستخدم رفع صورة جديدة
                            if (img.imageProfile != null) {
                              imageWidget = Image.file(
                                img.imageProfile!,
                                fit: BoxFit.cover,
                              );
                            }
                            // الحالة 2: الصورة من السيرفر (Network)
                            else if (auth.userEntity.image.isNotEmpty) {
                              imageWidget = Image.network(
                                auth.userEntity.image,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) =>
                                          Icon(Icons.person, size: 60.sp),
                              );
                            }
                            // الحالة 3: لا توجد صورة
                            else {
                              imageWidget =  Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey,
                              );
                            }

                            return ImageProfileUser(imageWidget: imageWidget);
                          },
                        ),

                        const VerticalSizedBox(vSmall),


                        /// أزرار الصورة
                        ControllerImage(),

                        const VerticalSizedBox(vMedium30),

                        /// ===== بيانات المستخدم =====
                        CustomUserTxtField(controller: _name, label: 'Name'),
                        const VerticalSizedBox(vMedium20),
                        CustomUserTxtField(controller: _email, label: 'Email'),
                        const VerticalSizedBox(vMedium20),
                        CustomUserTxtField(
                          controller: _address,
                          label: 'Address',
                        ),
                        const VerticalSizedBox(vMedium20),
                        const Divider(),
                        const VerticalSizedBox(vSmall),

                        /// ===== بطاقة الفيزا =====
                        auth.userEntity.visa!.isEmpty
                            ? CustomUserTxtField(
                              controller: _visa,
                              textInputType: TextInputType.number,
                              label: 'Add Visa Card',
                            )
                            : ContainerCardVisa(),

                        const VerticalSizedBox(vMedium20),

                        /// ===== أزرار Edit / Logout =====
                        Row(
                          children: [
                             BlocBuilder<AuthCubit,AuthState>(
                              buildWhen: (previous, current) => current is UpdateProfileSuccess || current is UpdateProfileLoading,
                              builder: (context, state) {
                                return  ButtonEditProfile(
                                  isLoading: state is UpdateProfileLoading,
                                  onTap: (){
                                  auth.updateProfileUser(UserModel(name: _name.text, email:_email.text,image:img.imageProfile!.path ,visa: _visa.text,address:  _address.text ));

                                },);
                              },

                            ),
                            const HorizontalSizedBox(hSmall),
                            ButtonLogout(),
                          ],
                        ),

                       ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
