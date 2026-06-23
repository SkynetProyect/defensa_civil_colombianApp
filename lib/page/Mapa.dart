import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/determinePosition.dart';
import 'package:flutter_application_1/widget/components/Unidad.dart';
import 'package:flutter_application_1/widget/maptools/MapTools.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget{

  Mapa({super.key});
  
  @override
  State<StatefulWidget> createState() => _mapaState();
  
}



class _mapaState extends State<Mapa>{

  Position? posicion;
  bool timeoutReached = false;
  late Timer _timer;

  void tomarPosicion() async {
    Position _posicion = await determinePosition();
    setState(() {
      posicion = _posicion;
      print('-->> posicion cambiada');
    });
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && posicion == null) {
        setState(() {
          timeoutReached = true;
        });
      }
    });
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      tomarPosicion();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 👈 always cancel or it leaks memory
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context){
    if (posicion == null && !timeoutReached) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack( 
    children: [ 
      FlutterMap(
      options: MapOptions(
        initialCenter: posicion != null
                  ? LatLng(posicion!.latitude, posicion!.longitude)
                  : LatLng(6.2442, -75.5812),
        initialZoom: 16,
        interactionOptions: InteractionOptions(
        flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.opentopomap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.test.rescueserviceapp',          
        ),
        MarkerLayer(
          markers: [
            
            Marker(
              point: posicion != null
                  ? LatLng(posicion!.latitude, posicion!.longitude)
                  : LatLng(6.2442, -75.5812),
              width: 40,
              height: 40,
              child: CustomPaint(size: Size(30, 30),
                painter: Unidad(colore: 
                  posicion != null ? const Color.fromARGB(255, 196, 3, 255) : const Color.fromARGB(0, 0, 0, 0).withValues(alpha: 0)
                  ))
            ),
          ],
        ),
      ],
      ),
      Container( // La flecha que dice norte
        height: 50,
        width: 50,
        margin: EdgeInsets.only(left: 5, top: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(150, 255, 252, 252)
        ),
        child: Column(
          children: [ Icon(Icons.arrow_upward), Text('NORTE') ] )
      ),
      MapTools() // las herramientas de mapa

    ]
    );
  }
}