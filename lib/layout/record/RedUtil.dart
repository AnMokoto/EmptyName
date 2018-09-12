import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';

class RedUtil {
  static Text buildText(String val, String isRed) {
    Color color = Colors.black54;
    print("$val===$isRed");
    if (isRed == '1') color = Colors.red;
    return new Text(
      "${val ?? "-"}",
      style: new TextStyle(
        color: color,
      ),
    );
  }

  static Text buildTextBool(String val, String isRed) {
    Color color = Colors.black54;
    print("$val===$isRed");
    if (isRed == 'true') color = Colors.red;
    return new Text(
      "${val ?? "-"}",
      style: new TextStyle(
        color: color,
      ),
    );
  }
}
