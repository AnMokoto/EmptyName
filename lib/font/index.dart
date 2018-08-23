library app.font;

import 'package:flutter/widgets.dart' show IconData;

class AppIcons {
  AppIcons._();

  static IconData passwd = IconData(0xe61d, fontFamily: "Alibaba");

  static IconData from(int codePoint) =>
      IconData(codePoint, fontFamily: "Alibaba");

  static IconData fromStr(String codePoint) =>
      IconData(int.parse(codePoint.replaceAll("&#x", "0x"), radix: 16),
          fontFamily: "Alibaba");
}
