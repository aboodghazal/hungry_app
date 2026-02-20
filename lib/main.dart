import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/global_bloc/image/image_cubit.dart';
import 'package:huungry/core/routes/go_routes.dart';

import 'core/cached/app_controller.dart';
import 'core/di/injector.dart';
import 'core/helpers/dio_helper.dart';
import 'features/home/presentations/manager/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

 await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureDependencies();
  DioHelper.init();
  //Bloc.observer = MyBlocObserver();

  await AppController.instance.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => ImageCubit(),),
    BlocProvider(
    create: (context) => HomeCubit(getIt(),getIt(),getIt(),getIt())..getCategory()..getProduct(),),
      ],
      child: MaterialApp.router(
        title: 'Hungry App',
        routerConfig: router,
        
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
        ),
       ),
    );
  }
}
