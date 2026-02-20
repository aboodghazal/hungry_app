
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/di/injector.dart';
import 'package:huungry/core/routes/routes.dart';
 import 'package:huungry/features/auth/presentations/manager/login/cubit.dart';
 import 'package:huungry/features/auth/presentations/pages/signup_view.dart';
import 'package:huungry/features/checkout/views/checkout_view.dart';
import 'package:huungry/features/home/presentations/manager/cubit.dart';
import 'package:huungry/features/product/presentations/manager/cubit.dart';
import 'package:huungry/root.dart';
import 'package:huungry/splash.dart';

import '../../features/auth/presentations/pages/login_view.dart';
import '../../features/product/presentations/pages/product_details_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.SPLASH,
    navigatorKey: navigatorKey,
     debugLogDiagnostics: true,

    // ✅ Global redirect with skip list
    // redirect: (context, state) {
    //   final loggedIn = AppController.instance.isLoggedIn();

    //   // Pages to skip redirect check
    //   final skipRedirectPages = {
    //     Routes.SPLASH,
    //     Routes.START_APP,
    //     Routes.LOGIN,
    //     Routes.VERIFY,
    //   };

    //   // If current route is in skip list, do nothing
    //   if (skipRedirectPages.contains(state.matchedLocation)) {
    //     return null;
    //   }

    //   // If not logged in, send to START_APP
    //   if (!loggedIn) {
    //     return Routes.START_APP;
    //   }

    //   return null;
    // },

    // ✅ Route definitions
    routes: [
      GoRoute(
        name: Routes.SPLASH,
        path: Routes.SPLASH,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        name: Routes.LOGIN,
        path: Routes.LOGIN,
        builder: (context, state) => BlocProvider
          (
          create: (context) => AuthCubit(getIt(),getIt(),getIt(),getIt(),getIt()),
            child: LoginView())
      ),
      GoRoute(
        name: Routes.SIGNUP,
        path: Routes.SIGNUP,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(getIt(), getIt(),getIt(),getIt(),getIt()),
            child: SignupView())
      ),
      GoRoute(
        name: Routes.DETAILS_PRODUCTS,
        path: Routes.DETAILS_PRODUCTS,
        builder: (context, state){
          int idProduct = -1;
          if(state.extra is int){
              idProduct = state.extra as int;
          }

         return BlocProvider(
              create: (context) => DetailsProductCubit(getIt(),getIt(),getIt(),getIt())..loadAllData(idProduct),
              child: ProductDetailsView(productId: idProduct,));
        }
      ),
      GoRoute(
        name: Routes.ROOT,
        path: Routes.ROOT,
        builder: (context, state) =>
             Root()),


      GoRoute(
        name: Routes.checkOut,
        path: Routes.checkOut,
        builder: (context, state){
          String price = '';
          if(state.extra is String){
            price = state.extra as String;
          }
         return CheckoutView(priceOrder: price,);
        },
      ),

    ],
  );
}
