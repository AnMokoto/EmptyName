library app.font;

class LotLineHeight {
  LotLineHeight._();

  /**
   * 购彩页面行高配置
   */
  static double calHeight(String gameEn, String playEn) {
    if (playEn.endsWith("hz")) {
      return 500.0;
    }if (playEn.contains("11x5")) {
      return 170.0;
    }
    if (playEn.contains("xglhc") ||
        playEn.contains("zmz1t") ||
        playEn.contains("zmz2t") ||
        playEn.contains("zmz3t") ||
        playEn.contains("zmz4t") ||
        playEn.contains("zmz5t") ||
        playEn.contains("zmz6t")) {
      return 600.0;
    }

    return 100.0;
  }
}
