import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huungry/core/cached/app_controller.dart';
import 'package:huungry/core/routes/routes.dart';
import 'core/assets/assets.gen.dart';
import 'core/themes/app_colors.dart';
import 'features/test.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _imageController;

  late Animation<Offset> _logoSlide;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  late Animation<Offset> _imageSlide;
  late Animation<double> _imageOpacity;

  @override
  void initState() {
    super.initState();

    // ===== Logo Animation =====
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _logoController.forward();

    // ===== Bottom Image Animation =====
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOutBack));

    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _imageController, curve: Curves.easeIn));

    _imageController.forward();

    // الانتقال بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), _checkLogin);
  }

  Future<void> _checkLogin() async {
    /*if (AppController.instance.isLoggedIn()) {
      context.goNamed(Routes.ROOT);
    } else {
      context.goNamed(Routes.LOGIN);
    }*/
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),));
  }

  @override
  void dispose() {
    _logoController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.9),
              AppColors.primary.withOpacity(0.6),
              AppColors.primary.withOpacity(0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // ===== Logo =====
            Center(
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoOpacity.value,
                    child: Transform.translate(
                      offset: _logoSlide.value * MediaQuery.of(context).size.height / 2,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Assets.logo.logo.svg(),
              ),
            ),

            // ===== Bottom Image =====
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: _imageController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _imageOpacity.value,
                    child: Transform.translate(
                      offset: _imageSlide.value * MediaQuery.of(context).size.height / 3,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Assets.splash.splash.image(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
