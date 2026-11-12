import 'dart:async';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();

  final List<String> banners = [
    'assets/images/jewellery_banner.png',
    'assets/images/jewellery_banner.png',
    'assets/images/jewellery_banner.png',
  ];

  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;

      currentIndex++;

      if (currentIndex >= banners.length) {
        currentIndex = 0;
      }

      _controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        controller: _controller,
        itemCount: banners.length,
        onPageChanged: (index) {
          currentIndex = index;
        },
        itemBuilder: (context, index) {
          return Image.asset(
            banners[index],
            fit: BoxFit.fill,
            width: double.minPositive,
          );
        },
      ),
    );
  }
}
