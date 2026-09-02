import 'package:flutter/material.dart';
import '../models/card_model.dart';

/// Draws a lightweight logotype/mark for each network so the card face
/// doesn't depend on bundled brand images.
class NetworkLogo extends StatelessWidget {
  final CardNetwork network;
  final Color color;
  const NetworkLogo({super.key, required this.network, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    switch (network) {
      case CardNetwork.visa:
        return Text(
          'VISA',
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
          ),
        );
      case CardNetwork.mastercard:
        return SizedBox(
          width: 46,
          height: 30,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB4F41),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 18,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4A72A).withOpacity(0.92),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      case CardNetwork.amex:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.16),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withOpacity(0.5), width: 1),
          ),
          child: Text(
            'AMEX',
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        );
      case CardNetwork.rupay:
        return Text(
          'RuPay',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        );
      case CardNetwork.discover:
        return Text(
          'discover',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        );
    }
  }
}
