
import 'package:flutter/material.dart';

class Unidad extends CustomPainter {
  Color colore;
  Unidad({
    required this.colore
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()
      ..color = colore
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = colore
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final cx = size.width / 2;

    // Circle
    canvas.drawCircle(
      Offset(cx, size.height * 0.55),
      size.width * 0.25,
      fill,
    );
 
    // Arrow head
    final head = Path()
      ..moveTo(cx, 0)
      ..lineTo(size.width * 0.62, size.height * 0.25)
      ..lineTo(size.width * 0.55, size.height * 0.25)
      ..lineTo(size.width * 0.55, size.height * 0.40)
      ..lineTo(size.width * 0.40, size.height * 0.40)
      ..lineTo(size.width * 0.40, size.height * 0.25)
      ..lineTo(size.width * 0.35, size.height * 0.25)
      ..close();

    canvas.drawPath(head, fill);
    canvas.drawPath(head, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}