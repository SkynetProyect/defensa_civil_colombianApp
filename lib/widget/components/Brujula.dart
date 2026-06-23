import 'package:flutter/material.dart' hide Size;
import 'dart:ui';
import 'dart:math';
/*
Como no habia ninguna brujula de imagen que me sirviera para lo que quiero hacer, la mejor opcion ha sido
crear mi propio widget de brujula.
*/

class Brujula extends StatefulWidget {
  const Brujula({super.key});

  @override
  State<Brujula> createState() => _BrujulaState();
}

class _BrujulaState extends State<Brujula> {
  double azimut = 0.0;

  // Current position
  Offset position = const Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                position += details.delta;
              });
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Transform.rotate(
                  angle: 0.1,
                  child: CustomPaint(
                    size: const Size(70, 120),
                    painter: _CompassBasePainter(),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: CustomPaint(
                    size: const Size(30, 30),
                    painter: _ArrowPainter(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
        top: 5,
        left: 5,
        child: 
        Container(
          height: 20,
          width: 400,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 5, 5, 5)
          ),
          child: Text('${azimut.toStringAsFixed(1)} Grados', style: 
            TextStyle(color: Color.fromARGB(255, 250, 96, 6))),
        )
        )

      ],
    );
  }
}

// De aqui para abajo se generan las clases con IA, esto ya son temas de dibujos y yo ahi no sirvo.

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 64)
      ..style = PaintingStyle.fill;

    final paintWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // red top half
    final pathRed = Path()
      ..moveTo(size.width / 2, 0)           // top point
      ..lineTo(size.width * 0.65, size.height / 2) // right middle
      ..lineTo(size.width / 2, size.height * 0.4)  // center indent
      ..lineTo(size.width * 0.35, size.height / 2) // left middle
      ..close();

    // white bottom half
    final pathWhite = Path()
      ..moveTo(size.width / 2, size.height)        // bottom point
      ..lineTo(size.width * 0.65, size.height / 2) // right middle
      ..lineTo(size.width / 2, size.height * 0.6)  // center indent
      ..lineTo(size.width * 0.35, size.height / 2) // left middle
      ..close();

    canvas.drawPath(pathRed, paint);
    canvas.drawPath(pathWhite, paintWhite);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}









class _CompassBasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final radius = 30.0;
    final cy = radius; // circle sits at top

    final white = Paint()
      ..color = const Color.fromARGB(100, 255, 255, 255)
      ..style = PaintingStyle.fill;

    final whiteBorder = Paint()
      ..color = const Color.fromARGB(255, 135, 159, 238)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // --- rectangular body ---
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - 35, 0, 70, 120),
      const Radius.circular(10),
    );
    canvas.drawRRect(body, white);
    canvas.drawRRect(body, whiteBorder);

    // --- outer bezel ---
    canvas.drawCircle(Offset(cx, cy), radius, Paint()
      ..color = const Color(0xFF2A2A2A));

    // --- inner dial ---
    canvas.drawCircle(Offset(cx, cy), radius * 0.72, Paint()
      ..color = Colors.white);

    // --- degree ticks + numbers ---
    for (int i = 0; i < 360; i += 2) {
      final angle = (i * pi / 180) - pi / 2;
      final isMajor = i % 10 == 0;
      final isMid = i % 5 == 0;

      final outerR = radius * 0.98;
      final innerR = isMajor ? radius * 0.82 : (isMid ? radius * 0.86 : radius * 0.90);

      canvas.drawLine(
        Offset(cx + outerR * cos(angle), cy + outerR * sin(angle)),
        Offset(cx + innerR * cos(angle), cy + innerR * sin(angle)),
        Paint()
          ..color = isMajor ? Colors.white : Colors.white60
          ..strokeWidth = isMajor ? 1.5 : 0.8,
      );

      if (isMajor) {
        final numR = radius * 0.7;
        final tx = cx + numR * cos(angle);
        final ty = cy + numR * sin(angle);
        final tp = TextPainter(
          text: TextSpan(
            text: '$i',
            style: TextStyle(
              color: Colors.white,
              fontSize: radius * 0.09,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        canvas.save();
        canvas.translate(tx, ty);
        canvas.rotate(angle + pi / 2);
        tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
        canvas.restore();
      }
    }

    // --- cardinals ---
    final cardinals = {'N': 0.0, 'E': 90.0, 'S': 180.0, 'W': 270.0};
    final cardinalColors = {
      'N': Colors.red, 'S': Colors.red,
      'E': const Color.fromARGB(255, 236, 221, 2), 'W': const Color.fromARGB(255, 42, 10, 226),
    };
    cardinals.forEach((letter, deg) {
      final angle = (deg * pi / 180) - pi / 2;
      final r = radius * 0.60;
      final tx = cx + r * cos(angle);
      final ty = cy + r * sin(angle);
      final tp = TextPainter(
        text: TextSpan(
          text: letter,
          style: TextStyle(
            color: cardinalColors[letter],
            fontSize: radius * 0.14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(tx - tp.width / 2, ty - tp.height / 2));
    });
    // --- needle ---
    final needlePaint = Paint()..style = PaintingStyle.fill;

    // --- center dot ---
    canvas.drawCircle(Offset(cx, cy), radius * 0.05, Paint()..color = const Color(0xFF2A2A2A));
    canvas.drawCircle(Offset(cx, cy), radius * 0.03, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}