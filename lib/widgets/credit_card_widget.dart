import 'package:flutter/material.dart';
import '../models/card_model.dart';
import 'network_logo.dart';

/// A realistic, aesthetic card face. Aspect ratio mirrors a physical
/// card (85.6mm x 53.98mm ≈ 1.586). Every element (chip, hologram strip,
/// number, names) is drawn — no image assets required.
class CreditCardWidget extends StatelessWidget {
  final CardModel card;
  final bool compact;

  const CreditCardWidget({super.key, required this.card, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.586,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: card.gradient,
          ),
          boxShadow: [
            BoxShadow(
              color: card.gradient.last.withOpacity(0.35),
              blurRadius: 24,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative depth: soft translucent orbs.
              Positioned(
                top: -40,
                right: -30,
                child: _orb(140, Colors.white.withOpacity(0.08)),
              ),
              Positioned(
                bottom: -60,
                left: -20,
                child: _orb(160, Colors.black.withOpacity(0.14)),
              ),
              // Diagonal sheen.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.06),
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? 16 : 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _topRow(),
                        _chipRow(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _numberRow(constraints.maxWidth),
                            SizedBox(height: compact ? 10 : 14),
                            _bottomRow(),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orb(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );

  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            card.bank,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 14 : 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.16),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            card.isCredit ? 'CREDIT' : 'DEBIT',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipRow() {
    return Row(
      children: [
        _chip(),
        const SizedBox(width: 10),
        Icon(
          Icons.wifi_rounded,
          color: Colors.white.withOpacity(0.85),
          size: compact ? 18 : 20,
        ),
      ],
    );
  }

  Widget _chip() {
    final h = compact ? 26.0 : 30.0;
    return Container(
      width: h * 1.3,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [Color(0xFFE8D190), Color(0xFFB89152)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _ChipLinesPainter()),
    );
  }

  Widget _numberRow(double maxWidth) {
    return Text(
      card.maskedNumber,
      style: TextStyle(
        color: Colors.white,
        fontSize: compact ? 15 : 18,
        fontWeight: FontWeight.w500,
        letterSpacing: compact ? 1.4 : 2.0,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  Widget _bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.holderName.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: compact ? 12 : 13.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'VALID THRU ${card.expiryLabel}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: compact ? 9.5 : 10.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        NetworkLogo(network: card.network),
      ],
    );
  }
}

class _ChipLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6B4E22).withOpacity(0.55)
      ..strokeWidth = 1;
    final midY = size.height / 2;
    final midX = size.width / 2;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), paint);
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), paint);
    final rect = Rect.fromLTWH(
      size.width * 0.22,
      size.height * 0.22,
      size.width * 0.56,
      size.height * 0.56,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(3)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
