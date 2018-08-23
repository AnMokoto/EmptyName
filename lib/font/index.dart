library app.font;

import 'package:flutter/widgets.dart' show IconData;

class AppIcons {
  AppIcons._();

  static IconData passwd = IconData(0xe630, fontFamily: "Alibaba");

  static IconData from(int codePoint) =>
      IconData(codePoint, fontFamily: "Alibaba");

  static IconData fromStr(String codePoint) =>
      IconData(int.parse(codePoint.replaceFirst("&#", "0"), radix: 16),
          fontFamily: "Alibaba");
}
