import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget implements PreferredSizeWidget {
  const MyHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72.0);

  @override
  Widget build(BuildContext context) {
    // Matches React Native StatusBar settings

    return Container(
      color: const Color(0xFF2B0008),
      child: SafeArea(
        bottom:
            false, // Only apply inset at the top, like useSafeAreaInsets().top
        child: SizedBox(
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: 62,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),

                // Text Container
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Brand Name
                    const Text(
                      'R P SILVER HOUSE',
                      style: TextStyle(
                        color: Color(0xFFE5A93B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Subtitle Row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Left Line
                        Container(
                          width: 14,
                          height: 1,
                          color: const Color(0xFFE5A93B).withValues(alpha: 0.7),
                        ),
                        // Subtitle Text
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            'PADRAUNA',
                            style: TextStyle(
                              color: Color(0xFFE5A93B),
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        // Right Line
                        Container(
                          width: 14,
                          height: 1,
                          color: const Color(0xFFE5A93B).withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
