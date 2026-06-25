import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Radiow extends StatefulWidget{
  static const kBg = Color.fromARGB(255, 13, 26, 26);
  static const kSurface = Color.fromARGB(255, 5, 15, 14);
  static const kBorder = Color.fromARGB(255, 26, 58, 31);
  static const kOrange = Color.fromARGB(255, 255, 187, 0);
  static const kGreen = Color.fromARGB(255, 0, 255, 213);

  @override
  State<StatefulWidget> createState() => _radio();

}

class _radio extends State<Radiow>{

  static bool _isOn = false;
  static bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;

    return 
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Radiow.kBg,
            border: Border.all(color: Radiow.kBorder, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(children: [

            // ── Channel input ──────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Radiow.kSurface,
                border: Border.all(color: Radiow.kGreen.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(children: [
                Text('DIGITE CANAL',
                  style: GoogleFonts.shareTechMono(
                    fontSize: 10, color: Radiow.kGreen.withOpacity(0.5), letterSpacing: 3)),
                const SizedBox(height: 6),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.shareTechMono(
                    fontSize: 28, color: Radiow.kGreen, letterSpacing: 8),
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '----',
                    hintStyle: GoogleFonts.shareTechMono(
                      fontSize: 28, color: Radiow.kGreen.withOpacity(0.2), letterSpacing: 8),
                  ),
                ),
              ]),
            ),

            const Divider(color: Radiow.kBorder, height: 28),

            // ── Toggle + PTT ───────────────────────────────────────────
            Row(children: [

              // Power toggle
              Column(children: [
                Text('PWR', style: GoogleFonts.shareTechMono(
                  fontSize: 9, color: Radiow.kGreen.withOpacity(0.6), letterSpacing: 2)),
                const SizedBox(height: 4),
                Switch(
                  value: _isOn,
                  onChanged: (v) => setState(() => _isOn = !_isOn),
                  activeColor: Radiow.kGreen,
                  activeTrackColor: Radiow.kBorder,
                  inactiveThumbColor: Radiow.kBorder,
                  inactiveTrackColor: Radiow.kSurface,
                ),
              ]),

              const SizedBox(width: 16),

              // PTT button
              Expanded(
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _pressing = true),
                  onTapUp: (_) => setState(() => _pressing = false),
                  onTapCancel: () => setState(() => _pressing = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 80),
                    height: 52,
                    decoration: BoxDecoration(
                      color: _pressing ? const Color(0xFF3A1500) : const Color(0xFF1A0A00),
                      border: Border.all(
                        color: _pressing ? Radiow.kOrange : Radiow.kOrange.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 18, height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Radiow.kOrange.withOpacity(0.7))),
                          child: Center(
                            child: Container(
                              width: 7, height: 7,
                              decoration: const BoxDecoration(
                                color: Radiow.kOrange, shape: BoxShape.circle))),
                        ),
                        const SizedBox(width: 10),
                        Text('PUSH TO TALK',
                          style: GoogleFonts.shareTechMono(
                            fontSize: 11, color: Radiow.kOrange, letterSpacing: 3)),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        );
  }
  
}