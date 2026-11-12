import 'package:flutter/material.dart';
import 'package:rp_silver_house/src/widgets/Homepage/custombox.dart';

import 'package:rp_silver_house/src/widgets/Homepage/ratecards.dart';
import 'package:rp_silver_house/src/widgets/Homepage/metalcard.dart';
import 'package:rp_silver_house/src/Services/rateservice.dart';
import 'package:rp_silver_house/src/widgets/Homepage/carousel.dart';
import 'package:rp_silver_house/src/widgets/Homepage/marquee.dart';
import 'package:rp_silver_house/src/widgets/Homepage/animated_headline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Rateservice rates = Rateservice();

  @override
  void initState() {
    super.initState();

    rates.startAutoRefresh(
      onUpdate: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    rates.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF2F2F7),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BannerCarousel(),
            SizedBox(height: 1),
            const AppMarquee(),

            const Custombox(
              child: Center(
                child: AnimatedHeadline(
                  title: 'रोज पहनने वाली लाइट वेट आइटम',
                  subtitle: 'लेटेस्ट अपडेट, मिनिमम रेट के साथ',
                ),
              ),
            ),

            // RateCard(
            //   title: 'Silver',
            //   subtitle: 'Cash Denial',
            //   amount: '₹ ${rates.msilver}',
            //   icon: Icons.monetization_on,
            //   iconColor: const Color(0xFFFFB800),
            // ),

            // SILVER
            RateCard(
              title: 'Silver',
              subtitle: 'Cash Denial',
              amount: '₹ ${rates.msilverrtgs}',
              updated: rates.updatedTime,
              image: 'assets/images/silver.png',
              isUp: rates.isSilverUp,
            ),

            RateCard(
              title: 'Gold BANK/GPAY',
              subtitle: 'Cash Denial',
              amount: '₹ ${rates.mgoldrtgs}',
              updated: rates.updatedTime,
              image: 'assets/images/bank.png',
              isUp: rates.isGoldUp,
            ),

            RateCard(
              title: 'Gold 99.50',
              subtitle: 'Cash Denial',
              amount: '₹ ${rates.mgold}',
              updated: rates.mgoldu,
              image: 'assets/images/gold.png',
            ),

            // GOLD NUMBER
            RateCard(
              title: 'Gold 99.99',
              subtitle: 'Cash Denial',
              amount: '₹ ${rates.mgoldn}',
              updated: rates.mgoldnu,
              image: 'assets/images/gold.png',
            ),
            SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: MetalCard(
                      title: 'Silver',
                      price: rates.silverRate == 0
                          ? '---'
                          : rates.silverRate.toString(),
                      change: rates.silverchg == 0
                          ? '---'
                          : rates.silverchg.toString(),
                      isUp: rates.isSilverUp,
                      image: 'assets/images/silver-mcx.png',
                     ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: MetalCard(
                      title: 'Gold',
                      price: rates.goldRate == 0
                          ? '---'
                          : rates.goldRate.toString(),
                      change: rates.goldchg == 0
                          ? '---'
                          : rates.goldchg.toString(),
                      isUp: rates.isGoldUp,
                      image: 'assets/images/gold-mcx.png',
                     ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
