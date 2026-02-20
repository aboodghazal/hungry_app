import 'package:flutter/material.dart';

// ----------------------------------------------------------------------
// 1. نموذج البيانات (Data Model) والبيانات الافتراضية
// ----------------------------------------------------------------------
class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final int shapeType; // 1: شكل الدرع (الشاشات الغامقة), 2: شكل القوس الدائري (الشاشات الصفراء)

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    required this.shapeType,
  });
}

// قائمة البيانات الافتراضية (مطابقة للشاشات الأربع في الصورة)
final List<OnboardingItem> onboardingData = [
  // Frame 1: الخلفية الغامقة - شكل الدرع (Shape 1)
  const OnboardingItem(
    title: 'كل الجمعيات التعاونية\nفي تطبيق واحد!',
    description: 'تصفح العروض، اعرف الفروع والمواعيد، وتابع أحدث التخفيضات بسهولة. Doomz يجمع لك 70% من تجارة التجزئة الكويتية في مكان واحد',
    imagePath: 'assets/images/frame1_map.png',
    color: Color(0xFF333333),
    shapeType: 1,
  ),
  // Frame 2: الخلفية الصفراء - شكل القوس الدائري (Shape 2)
  const OnboardingItem(
    title: 'أنشئ متجرك الخاص\nوابدأ الربح اليوم!',
    description: 'اختر منتجاتك المفضلة، اعرضها داخل Doomz. وابدأ بتحقيق العمولة من مشاركاتك',
    imagePath: 'assets/images/frame2_boxes.png',
    color: Color(0xFFFFCC00),
    shapeType: 2,
  ),
  // Frame 3: الخلفية الغامقة - شكل الدرع (Shape 1)
  const OnboardingItem(
    title: 'كن جزءًا من مجتمع\nالمتسوقين!',
    description: 'شارك نشرة أخبار المتسوقين، واكتشف ما يبرز داخل مجتمع Doomz اليومي',
    imagePath: 'assets/images/frame3_dress.png',
    color: Color(0xFF333333),
    shapeType: 1,
  ),
  // Frame 4: الخلفية الصفراء - شكل القوس الدائري (Shape 2)
  const OnboardingItem(
    title: 'تسوق بذكاء واستثمر\nمع كل عملية شراء!',
    description: 'مع Doomz، كل عملية شراء تمنحك عائدًا حقيقيًا. حول تسوقك اليومي إلى فرصة استثمارية.',
    imagePath: 'assets/images/frame4_bag.png',
    color: Color(0xFFFFCC00),
    shapeType: 2,
  ),
];

// ----------------------------------------------------------------------
// 2. Dynamic Custom Clipper (مُحدَّث ومُحسَّن)
// ----------------------------------------------------------------------
class DynamicOnboardingClipper extends CustomClipper<Path> {
  final int shapeType;

  DynamicOnboardingClipper(this.shapeType);

  @override
  Path getClip(Size size) {
    if (shapeType == 1) {
      // الشكل 1: الدرع المرتفع (Shield) - للشاشات الغامقة
      return _getShieldPath(size);
    } else {
      // الشكل 2: القوس الدائري الكبير (Simple Arc) - للشاشات الصفراء
      return _getSimpleCurvePath(size);
    }
  }

  // 📐 منطق رسم شكل الدرع (Shield/Cutout) - مُعدَّل للنعومة
  Path _getShieldPath(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();

    // تقليل العمق لجعله أقل بروزاً للداخل
    const cutoutDepth = 50.0;

    path.lineTo(0, 0); // الزاوية العلوية اليسرى
    path.lineTo(0, height); // النزول إلى الزاوية السفلية اليسرى (نهاية الخلفية)

    // نقطة الذروة (Apex): أقرب للحافة السفلية
    final apexPoint = Offset(width / 2, height - cutoutDepth);

    // منحنى يسار (سحب قليل جداً لأسفل لزيادة النعومة)
    path.quadraticBezierTo(
      width * 0.2,
      height + 10,
      apexPoint.dx,
      apexPoint.dy,
    );

    // منحنى يمين (سحب قليل جداً لأسفل لزيادة النعومة)
    path.quadraticBezierTo(
      width * 0.8,
      height + 10,
      width,
      height, // الانتهاء عند الزاوية السفلية اليمنى
    );

    path.lineTo(width, 0); // العودة للزاوية العلوية اليمنى
    path.close();
    return path;
  }

  // 📐 منطق رسم القوس الدائري الكبير (Simple Arc) - مُعدَّل للشكل الدائري
  Path _getSimpleCurvePath(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();

    path.lineTo(0, 0); // الزاوية العلوية اليسرى
    path.lineTo(0, height); // النزول إلى الزاوية السفلية اليسرى

    // نضع نقطة التحكم بعمق أكبر (150) لإنشاء قوس دائري كبير وناعم جداً
    final controlPoint = Offset(width / 2, height + 150);
    final endPoint = Offset(width, height);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant DynamicOnboardingClipper oldClipper) => oldClipper.shapeType != shapeType;
}

// ----------------------------------------------------------------------
// 3. Onboarding Page - بناء كل صفحة على حدة
// ----------------------------------------------------------------------
class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final curveHeight = screenHeight * 0.5;

    return Stack(
      children: [
        // الخلفية الملونة (الأصفر أو الغامق)
        ClipPath(
          clipper: DynamicOnboardingClipper(item.shapeType),
          child: Container(
            height: curveHeight,
            width: double.infinity,
            color: item.color,
          ),
        ),

        // المحتوى الرئيسي
        Column(
          children: [
            // منطقة الصورة التوضيحية
            Container(
              height: screenHeight * 0.4,
              alignment: Alignment.center,
              child: SizedBox(
                height: 280,
                width: 280,
                // هنا يجب وضع الـ Image/SVG/Illustration (باستخدام item.imagePath)
                child: Placeholder(color: Colors.grey.withOpacity(0.5)),
              ),
            ),

            // الشكل المثلثي (الـ Pointer)
            const Icon(Icons.arrow_drop_up, size: 40, color: Colors.black),

            // النصوص
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  // Title (العنوان)
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description (الوصف)
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF6C6C6C)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ----------------------------------------------------------------------
// 4. Onboarding Screen - التحكم في الـ PageView والمؤشرات
// ----------------------------------------------------------------------
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(context),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(item: onboardingData[index]);
                },
              ),
            ),
            _buildBottomNavigation(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_cart, color: Colors.black, size: 24),
              const SizedBox(width: 6),
              const Text('DOOMZ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: const Row(
              children: [
                Text('En', style: TextStyle(fontWeight: FontWeight.w600)),
                Icon(Icons.keyboard_arrow_down, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final isLastPage = _currentPage == onboardingData.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر التخطي (Skip)
          TextButton(
            onPressed: () {},
            child: const Text('تخطي', style: TextStyle(color: Colors.black, fontSize: 16)),
          ),

          // مؤشرات التقدم (Dots)
          Row(
            children: List.generate(
              onboardingData.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == _currentPage ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  // لون المؤشر يتغير حسب لون خلفية الصفحة الحالية
                  color: index == _currentPage ? onboardingData[index].color : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          // زر التالي (Next)
          TextButton(
            onPressed: () {
              if (isLastPage) {
                // الانتقال إلى التطبيق
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              isLastPage ? 'ابدأ' : 'التالي',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}