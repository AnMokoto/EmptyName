library app.font;

import 'package:lowlottery/store/sp.dart';

class CacheKey {
  static String lots = 'lotConf';
  static String _plays = 'lotPlayConf';

  static String getPlayKey() {
    return SPHelper.getKey(_plays);
  }

  static String getLotKey(String type) {
    return SPHelper.getKey('$lots$type');
  }
}
