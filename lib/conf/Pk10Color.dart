library app.font;

import 'package:flutter/material.dart';

/**
 * pk10 颜色
 */
class Pk10Color {
  Pk10Color._();

  static Color colors(String gameEn) {
    if (gameEn == "01") return Colors.yellow;
    if (gameEn == "02") return Colors.lightBlue;
    if (gameEn == "03") return Colors.grey;
    if (gameEn == "04") return Colors.orange;
    if (gameEn == "05") return Colors.indigo;
    if (gameEn == "06") return Colors.purple;
    if (gameEn == "07") return Colors.blueGrey;
    if (gameEn == "08") return Colors.red;
    if (gameEn == "09") return Colors.black54;
    if (gameEn == "10") return Colors.green;
  }
}
