import 'package:flutter/material.dart';
import 'package:rp_silver_house/src/widgets/Homepage/custombox.dart';

class RateCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;

  final bool? isUp;

  final String? updated;

  // Optional image asset.
  // If null, the default icon is shown.
  final String? image;

  // Fallback icon
  final IconData icon;
  final Color iconColor;

  const RateCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isUp,
    this.updated,
    this.image,
    this.icon = Icons.inventory_2,
    this.iconColor = const Color(0xFFF5A623),
  });

  @override
  Widget build(BuildContext context) {
    final Color trendColor;

    if (isUp == null) {
      trendColor = const Color(0xFF8C8C8C);
    } else if (isUp == true) {
      trendColor = const Color(0xFF27AE60);
    } else {
      trendColor = const Color(0xFFD9383A);
    }

    final IconData trendIcon;

    if (isUp == null) {
      trendIcon = Icons.remove_circle_outline;
    } else if (isUp == true) {
      trendIcon = Icons.arrow_upward;
    } else {
      trendIcon = Icons.arrow_downward;
    }

    return Custombox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ------------------------------------------------
          // LEFT SECTION
          // ------------------------------------------------
          Expanded(
            child: Row(
              children: [
                // IMAGE / ICON
                SizedBox(
                  width: 36,
                  height: 36,
                  child: image != null && image!.isNotEmpty
                      ? Image.asset(
                          image!,
                          width: 80,
                          height: 30,
                          fit: BoxFit.cover,
                        )
                      : Icon(icon, size: 28, color: iconColor),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      SizedBox(
                        width: double.infinity,
                        height: 21,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D0D0D),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // SUBTITLE
                      SizedBox(
                        width: double.infinity,
                        height: 19,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ------------------------------------------------
          // RIGHT SECTION
          // ------------------------------------------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // PRICE + TREND
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 150),
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: trendColor, width: 1.5),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 125),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          ' $amount',
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 69, 69, 69),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Icon(trendIcon, size: 20, color: trendColor),
                ],
              ),

              const SizedBox(height: 4),

              // Spacer (keeps the same layout height as the old H/L row)
              const SizedBox(height: 16),

              const SizedBox(height: 2),

              // UPDATED
              SizedBox(
                height: 15,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Updated - ${updated ?? '---'}',
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF303030),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
