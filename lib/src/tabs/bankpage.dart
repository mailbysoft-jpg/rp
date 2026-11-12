import 'package:flutter/material.dart';

class Bankpage extends StatelessWidget {
  const Bankpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF9FAFB),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          // SILVER DIVISION HEADER
          _buildHeader('Silver Division', const Color(0xFF94A3B8)),
          const SizedBox(height: 12),

          // SILVER CARD
          _buildCard(
            bankName: 'Central Bank of India',
            badgeText: 'SILVER',
            accentColor: const Color(0xFF0D69AB),
            badgeBg: const Color(0xFFE2E8F0),
            name: 'M/s Rp Silver House',
            accNo: '3580 700 338',
            ifsc: 'CBIN0280201',
            logoAsset:
                'assets/images/central_bank.png', // Specify the asset path for the bank logo
          ),
          const SizedBox(height: 20),

          // GOLD DIVISION HEADER
          _buildHeader('Gold Division', const Color(0xFFD4A72C)),
          const SizedBox(height: 12),

          // GOLD CARD
          _buildCard(
            bankName: 'Central Bank of India',
            badgeText: 'GOLD',
            accentColor: const Color(0xFF0D69AB),
            badgeBg: const Color(0xFFFEF3C7),
            name: 'Hanu Jewellers',
            accNo: '5981 0694 92',
            ifsc: 'CBIN0280201',
            logoAsset:
                'assets/images/central_bank.png', // Specify the asset path for the bank logo
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, Color dotColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 9),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        const Text(
          '1 Bank',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String bankName,
    required String badgeText,
    required Color accentColor,
    required Color badgeBg,
    required String name,
    required String accNo,
    required String ifsc,
    String? logoAsset, // Pass 'assets/images/central_bank.png'
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Bank Logo / Icon Container
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(
                  8,
                ), // Inner padding keeps the emblem balanced
                decoration: BoxDecoration(
                  color:
                      Colors.white, // White background suits bank logos better
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFF1F1F2),
                  ), // Clean subtle border
                ),
                child: logoAsset != null
                    ? Image.asset(logoAsset, fit: BoxFit.contain)
                    : Icon(
                        Icons.business_outlined,
                        size: 25,
                        color: accentColor,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Padrauna',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1, color: Color(0xFFF1F1F2)),

          const Text(
            'Name',
            style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),
          const Text(
            'Account Number',
            style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 4),
          Text(
            accNo,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),
          const Text(
            'IFSC Code',
            style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 4),
          Text(
            ifsc,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
