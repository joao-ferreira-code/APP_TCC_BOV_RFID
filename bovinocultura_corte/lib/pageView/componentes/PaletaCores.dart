
import 'package:flutter/material.dart';

class Palette {
/* Cores PreDeterminadas pelo FLUTTER
    1. Primary
    2. Primary Variant
    3. Secondary
    4. Secondary Variant
    5. Background
    6. Surface
    7. Error
    8. On Primary
    9. On Secondary
    10. On Background
    11. On Surface
    12. On Error
*/

//============================================================================//

  static const MaterialColor primary = const MaterialColor(
    0xa6003c64,
    const <int, Color>{
      50: const Color(0x80E3EDF2),//10%
      100: const Color(0xFFE3EDF2),//10%
      200: const Color(0xFFA0C8DC),//20%
      300: const Color(0xE6568EA9),//30%
      400: const Color(0xE6568EA9),//40%
      500: const Color(0xff003c64),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );


//============================================================================//

  static const MaterialColor colorBeckground = const MaterialColor(
    0xffD96236,
    const <int, Color>{
      100: const Color(0x1ad96236),//10%
      200: const Color(0x33d96236),//20%
      300: const Color(0x4dd96236),//30%
      400: const Color(0x66d96236),//40%
      500: const Color(0x80d96236),//50%
      600: const Color(0x99d96236),//60%
      700: const Color(0xb3d96236),//70%
      800: const Color(0xccd96236),//80%
      900: const Color(0xe6d96236),//90%
      1000: const Color(0xffd96236),//100%
    },
  );

//============================================================================//

  static const MaterialColor main = const MaterialColor(
    0xff023C5A,
    const <int, Color>{
      50: const Color(0x80FFFFFF),//10%
      100: const Color(0xE6E3EDF2),//10%
      200: const Color(0xFF9FC9DD),//20%
      300: const Color(0xFF023C5A),//30%
      400: const Color(0xE6568EA9),//40%
      500: const Color(0x803C4473),//50%
      600: const Color(0x993c4473),//60%
      700: const Color(0xb33c4473),//70%
      800: const Color(0xcc00324d),//80%
      900: const Color(0xe600324d),//90%
      1000: const Color(0xff023C5A),//100%
    },
  );

//============================================================================//

  static const MaterialColor black = const MaterialColor(
    0xff000000,
    const <int, Color>{
      100: const Color(0x1a000000),//10%
      200: const Color(0x33000000),//20%
      300: const Color(0x4d000000),//30%
      400: const Color(0x66000000),//40%
      500: const Color(0x80000000),//50%
      600: const Color(0x99000000),//60%
      700: const Color(0xb3000000),//70%
      800: const Color(0xcc000000),//80%
      900: const Color(0xe6000000),//90%
      1000: const Color(0xff000000),//100%
    },
  );

//============================================================================//


}