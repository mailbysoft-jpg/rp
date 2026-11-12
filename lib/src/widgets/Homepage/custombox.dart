import 'package:flutter/material.dart';

class Custombox extends StatelessWidget {
  final Widget child;

  const Custombox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const double radius = 22.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 2,
      ),
       decoration: BoxDecoration(
        color: const Color(0xFFD4D1D1),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(143, 155, 179, 0.25),
            offset: Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      // Margin on the bottom exposes 4px of the background base
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFC2BFBF),
            width: 0.5,
          ),
        ),
        child: child,
      ),
    );
  }
}