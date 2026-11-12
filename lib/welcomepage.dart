import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _buttonController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _buttonSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    );

    // Button animation controller
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
          ),
        );

    _buttonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
        );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await _mainController.forward();

    if (mounted) {
      await _buttonController.forward();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B0008),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // --------------------------------------------------
              // LOGO
              // --------------------------------------------------
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // --------------------------------------------------
              // BRAND
              // --------------------------------------------------
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      const Text(
                        'RP SILVER HOUSE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4,
                        ),
                      ),

                      Container(
                        width: 55,
                        height: 1,
                        color: const Color(0xFFD4AF37),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                      ),

                      const Text(
                        'TIMELESS BEAUTY • MODERN ELEGANCE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF1D27A),
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --------------------------------------------------
              // MAIN CONTENT
              // --------------------------------------------------
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Shine With\nElegance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFF8E7),
                              fontSize: 42,
                              height: 1.19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 22),

                          const Text(
                            'Discover beautiful silver jewellery, '
                            'crafted to make every moment special.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD8C9C0),
                              fontSize: 15,
                              height: 1.53,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // --------------------------------------------------
              // GET STARTED BUTTON
              // --------------------------------------------------
              SlideTransition(
                position: _buttonSlideAnimation,
                child: FadeTransition(
                  opacity: _buttonController,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: const Color(0xFF2B0008),
                          elevation: 5,
                          shadowColor: Colors.black.withValues(alpha: 0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'GET STARTED',
                              style: TextStyle(
                                color: Color(0xFF2B0008),
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Text(
                              '→',
                              style: TextStyle(
                                color: Color(0xFF2B0008),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
