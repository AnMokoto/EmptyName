library app.font;

import 'package:lowlottery/store/sp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/store/models/playModel.dart';
export 'package:lowlottery/store/models/playModel.dart';
import 'dart:math';
import 'package:reflectable/reflectable.dart';
import 'XglhcColor.dart';

class HaomaoColor {
  static Color haoma(String playEn, String number) {
    if (playEn == 'xglhc_tmzx'
        || playEn.contains("xglhc_lm2z")
        || playEn.contains("xglhc_lm3z")
        || playEn.contains("xglhc_bz")
        || playEn.contains("xglhc_zmz6t")
        || playEn.contains("xglhc_zmz5t")
        || playEn.contains("xglhc_zmz4t")
        || playEn.contains("xglhc_zmz3t")
        || playEn.contains("xglhc_zmz2t")
        || playEn.contains("xglhc_zmz1t")
    ) {
      return XglhcColor.colors(number);

    }

    return Colors.red;
  }
}
