import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Centered, animated headline: a maroon pill with a gold shimmer sweeping
/// across the title, and a subtitle that slides/fades in and then keeps a
/// soft shimmer.
class AnimatedHeadline extends StatefulWidget {
  final String title;
  final String subtitle;

  const AnimatedHeadline({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<AnimatedHeadline> createState() => _AnimatedHeadlineState();
}

class _AnimatedHeadlineState extends State<AnimatedHeadline>
    with TickerProviderStateMixin {
  late final AnimationController _shimmer;
  late final AnimationController _intro;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();

    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    _intro.dispose();
    super.dispose();
  }

  /// Gradient band that slides from left to right as [t] goes 0 → 1.
  Shader _shimmerShader(Rect bounds, double t, List<Color> colors) {
    final dx = bounds.width * (t * 3 - 1.5);
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: colors,
      stops: const [0.35, 0.5, 0.65],
      transform: _SlideGradient(dx),
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    final introCurve =
        CurvedAnimation(parent: _intro, curve: Curves.easeOutBack);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------- TITLE PILL ----------------
        ScaleTransition(
          scale: Tween(begin: 0.85, end: 1.0).animate(introCurve),
          child: AnimatedBuilder(
            animation: _shimmer,
            builder: (context, child) {
              final pulse =
                  (math.sin(_shimmer.value * 2 * math.pi) + 1) / 2; // 0..1
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A0612), Color(0xFF2D0209)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFD4A017)
                        .withValues(alpha: 0.35 + 0.4 * pulse),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4A017)
                          .withValues(alpha: 0.12 + 0.18 * pulse),
                      blurRadius: 6 + 6 * pulse,
                    ),
                  ],
                ),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => _shimmerShader(
                    bounds,
                    _shimmer.value,
                    const [Colors.white, Color(0xFFFFD86B), Colors.white],
                  ),
                  child: child,
                ),
              );
            },
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // ---------------- SUBTITLE ----------------
        FadeTransition(
          opacity: CurvedAnimation(
            parent: _intro,
            curve: const Interval(0.3, 1, curve: Curves.easeOut),
          ),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.6),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _intro,
                curve: const Interval(0.3, 1, curve: Curves.easeOut),
              ),
            ),
            child: AnimatedBuilder(
              animation: _shimmer,
              builder: (context, child) => ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => _shimmerShader(
                  bounds,
                  _shimmer.value,
                  const [
                    Color(0xFF222222),
                    Color(0xFFB8860B),
                    Color(0xFF222222),
                  ],
                ),
                child: child,
              ),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SlideGradient extends GradientTransform {
  final double dx;
  const _SlideGradient(this.dx);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(dx, 0, 0);
}
