import 'package:flutter/material.dart';

class AppMarquee extends StatefulWidget {
  const AppMarquee({super.key});

  @override
  State<AppMarquee> createState() => _AppMarqueeState();
}

class _AppMarqueeState extends State<AppMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: const Color(0xFF2D0209),
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final screenWidth = constraints.maxWidth;

                return Transform.translate(
                  offset: Offset(
                    screenWidth - (_controller.value * (screenWidth + 350)),
                    0,
                  ),
                  child: child,
                );
              },
              child: const SizedBox(
                width: 350,
                height: 40,
                child: Center(
                  child: Text(
                    'आरपी सिल्वर हाउस में आपका स्वागत है!',
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFA705),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
