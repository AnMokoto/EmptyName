/**
 * 直选复选
 */
class Pk10Zhushuzxfx {
  /**
   * 计算注数 同位之间多个号码用空格分割。不同位之间用逗号分割 <>
   *
   * </>1 2 3,4 5    ==== 3 * 2 =6注 <>
   *
   * </>1,2 3,4 5   ===== 1 * 2 * 2 = 4注
   */

  static var spce = " ";

  static int calZhushu(String code) {
    List<String> arr = split(code, ",");
    int len = arr.length;
    int zhushu = 0;
    switch (len) {
      case 1:
        zhushu = r1(arr);
        break;
      case 2:
        zhushu = r2(arr);
        break;
      case 3:
        zhushu = r3(arr);
        break;
      case 4:
        zhushu = r4(arr);
        break;
      case 5:
        zhushu = r5(arr);
        break;
    }

    return zhushu;
  }

  static List<String> split(String code, String char) {
    return code.replaceAll("-", "").trim().split(char);
  }

  static int r1(List<String> arr) {
    Set<String> f1 = split(arr[0], spce).toSet();
    if(valid(f1)==1) return 0 ;
    return f1.length;
  }

  static int r2(List<String> arr) {
    List<String> f1 = split(arr[0], spce);
    List<String> f2 = split(arr[1], spce);
    int zhushu = 0;
    for (int i = 0; i < f1.length; i++) {
      for (int j = 0; j < f2.length; j++) {
        Set<String> set = [f1[i], f2[j]].toSet();
        if (valid(set)==0 && set.length == 2) {
          zhushu++;
        }
      }
    }
    return zhushu;
  }

  static int r3(List<String> arr) {
    List<String> f1 = split(arr[0], spce);
    List<String> f2 = split(arr[1], spce);
    List<String> f3 = split(arr[2], spce);
    int zhushu = 0;
    for (int i = 0; i < f1.length; i++) {
      for (int j = 0; j < f2.length; j++) {
        for (int k = 0; k < f3.length; k++) {
//          print("{},{},{}", f1.get(i), f2.get(j), f3.get(k));
          Set<String> set = [f1[i], f2[j], f3[k]].toSet();
          if (valid(set)==0 &&set.length == 3) {
            zhushu = zhushu + 1;
          }
        }
      }
    }
    return zhushu;
  }

  static int r4(List<String> arr) {
    List<String> f1 = split(arr[0], spce);
    List<String> f2 = split(arr[1], spce);
    List<String> f3 = split(arr[2], spce);
    List<String> f4 = split(arr[3], spce);
    int zhushu = 0;
    for (int i = 0; i < f1.length; i++) {
      for (int j = 0; j < f2.length; j++) {
        for (int k = 0; k < f3.length; k++) {
          for (int l = 0; l < f4.length; l++) {
//            log.info("{},{},{},{}", f1.get(i), f2.get(j), f3.get(k), f4.get(l));
            Set<String> set = [f1[i], f2[j], f3[k], f4[l]].toSet();
            if (valid(set)==0 &&set.length == 4) {
              zhushu++;
            }
          }
        }
      }
    }
    return zhushu;
  }

  static int r5(List<String> arr) {
    List<String> f1 = split(arr[0], spce);
    List<String> f2 = split(arr[1], spce);
    List<String> f3 = split(arr[2], spce);
    List<String> f4 = split(arr[3], spce);
    List<String> f5 = split(arr[4], spce);
    int zhushu = 0;
    for (int i = 0; i < f1.length; i++) {
      for (int j = 0; j < f2.length; j++) {
        for (int k = 0; k < f3.length; k++) {
          for (int l = 0; l < f4.length; l++) {
            for (int m = 0; m < f5.length; m++) {
              Set<String> set = [f1[i], f2[j], f3[k], f4[l], f5[m]].toSet();
              if (valid(set)==0 && set.length == 5) {
                zhushu++;
              }
            }
          }
        }
      }
    }
    return zhushu;
  }

  static int valid(Set<String> set) {
    for (var value in set) {
      if (value == null || value.trim() == '')
        return 1;
    }
    return 0;
  }
}
