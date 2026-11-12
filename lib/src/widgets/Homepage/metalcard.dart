import 'dart:math' as math;

import 'package:flutter/material.dart';

class MetalCard extends StatelessWidget {
  final String title;
  final String price;
  final String change;
  final bool isUp;

  // Optional image asset
  final String? image;

  // Fallback icon
  final IconData icon;
  final Color iconColor;

  const MetalCard({
    super.key,
    required this.title,
    required this.price,
    required this.change,
    this.isUp = true,
    this.image,
    this.icon = Icons.inventory_2,
    this.iconColor = const Color(0xFFF5A623),
  });

  @override
  Widget build(BuildContext context) {
    // Direction follows the sign of the change value itself;
    // falls back to isUp only when the change isn't a number.
    final changeValue = double.tryParse(change.trim());
    final isUp = changeValue != null ? changeValue >= 0 : this.isUp;

    final cleanChange = change.trim().replaceFirst(RegExp(r'^[+-]'), '');
    final formattedChange =
        changeValue != null ? '${isUp ? '+' : '-'}$cleanChange' : cleanChange;

    final pillBg = isUp ? const Color(0xFFE2F9D3) : const Color(0xFFFFEAEB);

    final arrowBg = isUp ? const Color(0xFF27AE60) : const Color(0xFFEB5757);

    final arrowIcon = isUp ? Icons.arrow_upward : Icons.arrow_downward;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // ------------------------------------------------
        // CARD
        // ------------------------------------------------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 14,
            left: 12,
            right: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFDCDfe4)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(57, 56, 56, 0.251),
                offset: Offset(2, 4),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              Text(
                title.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6C757D),
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 4),

              // PRICE
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '₹ $price',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // CHANGE PILL
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: pillBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ARROW CIRCLE
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: arrowBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(arrowIcon, size: 11, color: Colors.white),
                    ),

                    const SizedBox(width: 6),

                    // CHANGE
                    Text(
                      formattedChange,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF212529),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ------------------------------------------------
        // FLOATING IMAGE / ICON
        // ------------------------------------------------
        Positioned(
          top: -24,
          child: _MetalBadge(
            isGold: title.toLowerCase().contains('gold'),
            child: image != null && image!.isNotEmpty
                ? Image.asset(image!, fit: BoxFit.contain)
                : Icon(icon, size: 22, color: iconColor),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------
// ANIMATED METAL BADGE
// Rotating metallic ring + pulsing glow + gentle float.
// ------------------------------------------------
class _MetalBadge extends StatefulWidget {
  final bool isGold;
  final Widget child;

  const _MetalBadge({required this.isGold, required this.child});

  @override
  State<_MetalBadge> createState() => _MetalBadgeState();
}

class _MetalBadgeState extends State<_MetalBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringColors = widget.isGold
        ? const [
            Color(0xFFFFF3B0),
            Color(0xFFD4A017),
            Color(0xFF8B6508),
            Color(0xFFFFD700),
            Color(0xFFFFF3B0),
          ]
        : const [
            Color(0xFFFFFFFF),
            Color(0xFFB8BEC6),
            Color(0xFF6E7681),
            Color(0xFFDDE2E8),
            Color(0xFFFFFFFF),
          ];

    final glowColor =
        widget.isGold ? const Color(0xFFFFC107) : const Color(0xFF9EA7B3);

    final innerColors = widget.isGold
        ? const [Color(0xFFFFFDF2), Color(0xFFFFF1C9)]
        : const [Color(0xFFFFFFFF), Color(0xFFEDF0F4)];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final wave = math.sin(t * 2 * math.pi); // -1..1
        final pulse = (wave + 1) / 2; // 0..1

        return Transform.translate(
          offset: Offset(0, -1.5 * wave),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.25 + 0.30 * pulse),
                  blurRadius: 6 + 6 * pulse,
                  spreadRadius: 0.5 + 1.5 * pulse,
                ),
                const BoxShadow(
                  color: Color(0x22000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating metallic ring
                Transform.rotate(
                  angle: t * 2 * math.pi,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(colors: ringColors),
                    ),
                  ),
                ),

                // Inner face
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(-0.3, -0.4),
                      radius: 0.9,
                      colors: innerColors,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),

                // Moving shine highlight
                IgnorePointer(
                  child: ClipOval(
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: Transform.translate(
                        offset: Offset(-60 + 120 * t, 0),
                        child: Transform.rotate(
                          angle: 0.5,
                          child: Container(
                            width: 10,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0),
                                  Colors.white.withValues(alpha: 0.7),
                                  Colors.white.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
