class ZuheUtil {
  /**
   * log
   * 计算阶乘数，即n! = n * (n-1) * ... * 2 * 1
   */
  static double factorial(int n) {
    return ((n > 1) ? n * factorial(n - 1) : 1).toDouble();
  }

  /**
   * 计算组合数，即C(n, m) = n!/((n-m)! * m!)
   */

  static double combination(int n, int m) {
    return (n >= m) ? factorial(n) / factorial(n - m) / factorial(m) : 0.0;
  }
}
