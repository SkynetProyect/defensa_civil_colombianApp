
import 'package:flutter/widgets.dart';

class Dibujo extends StatefulWidget{
  const Dibujo({
    super.key });

  @override
  State<StatefulWidget> createState() => _dibujo();
  
}

class _dibujo extends State<Dibujo>{
  List<CustomPaint> dibujos = [];
  static double startX = 0.0;
  static double startY = 0.0;
  static double endX = 0.0;
  static double endY = 0.0;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double width = size.width/1.05;
    double height = size.height/1.15;

    return GestureDetector(
    onDoubleTap: () {
      setState(() {
        dibujos.removeLast();
      });
    },
    onPanStart: (DragStartDetails detalles) {
      setState(() {
        startX = detalles.localPosition.dx;
        startY = detalles.localPosition.dy;
      });
    },
    onPanUpdate: (details) {
      setState(() {
        endX = details.localPosition.dx;
        endY = details.localPosition.dy;
      });
    },
    onPanEnd: (DragEndDetails details) {
      setState(() {
       dibujos.add(CustomPaint(
          size: Size(width, height),
          painter: _Linea(startX: startX, startY: startY, endX: endX, endY: endY),
        ));
      });
    } ,
    child: 
      Container( 
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromARGB(97, 96, 96, 148),
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(
            color: Color.fromARGB(255, 255, 255, 255)
          )
        ),
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: dibujos,
        ),
      )
    );
  }

  
}

class _Linea extends CustomPainter{
  final double startX;
  final double startY;
  final double endX;
  final double endY;

  const _Linea({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY
  });


  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(startX, startY), 
      Offset(endX, endY), 
      Paint()
        ..color = Color.fromARGB(255, 9, 255, 1)
        ..style = PaintingStyle.fill
        ..strokeWidth = 4);
  }

  @override
  //bool shouldRepaint(covariant CustomPainter oldDelegate) => false; esto se pone si el dibujo nunca cambia
  bool shouldRepaint(covariant _Linea oldDelegate) {
    return oldDelegate.startX != startX ||
          oldDelegate.startY != startY ||
          oldDelegate.endX != endX ||
          oldDelegate.endY != endY;
  }
  
}
