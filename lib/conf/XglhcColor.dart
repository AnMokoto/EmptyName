library app.font;

import 'package:flutter/material.dart';

/**
 * pk10 颜色
 */
class XglhcColor {
  XglhcColor._();

  static var _red = [
    '01',
    '02',
    '07',
    '08',
    '13',
    '19',
    '12',
    '18',
    '23',
    '24',
    '29',
    '30',
    '34',
    '35',
    '35',
    '45',
    '46'
  ];
  static var _green = [
    '05',
    '06',
    '11',
    '16',
    '17',
    '21',
    '22',
    '27',
    '28',
    '32',
    '33',
    '38',
    '39',
    '43',
    '44',
    '49',
  ];

  static Color colors(String gameEn) {
    if (_red.contains(gameEn)) return Colors.red;
    if (_green.contains(gameEn)) return Colors.green;
    return Colors.blue;
  }
}
