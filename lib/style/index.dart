library app.style;

import 'style.dart';
import 'cqssc.dart';
import '11x5.dart';
import 'pk10.dart';
import 'kl10.dart';
import 'xglhc.dart';
import 'k3.dart';

export 'style.dart';

/// for debug export
export 'cqssc.dart';

class StyleSplit {
  StyleSplit._();

  static List<String> playEns = [
    'playEn',
    'ssc_1xfx',
    'ssc_q2zxfx',
    'ssc_q2zxhz',
    'ssc_q2zxkd',
    'ssc_q2zuxfx',
    'ssc_q2zuxhz',
    'ssc_q2zuxbd',
    'ssc_h2zxfx',
    'ssc_h2zxhz',
    'ssc_h2zxkd',
    'ssc_h2zuxfx',
    'ssc_h2zuxhz',
    'ssc_h2zuxbd',
    'ssc_q3zxfx',
    'ssc_q3zxhz',
    'ssc_q3zxkd',
    'ssc_q3ybd',
    'ssc_q3ebd',
    'ssc_h3zxfx',
    'ssc_h3zxhz',
    'ssc_h3zxkd',
    'ssc_h3ybd',
    'ssc_h3ebd',
    'ssc_z3zxfx',
    'ssc_z3zxhz',
    'ssc_z3zxkd',
    'ssc_z3ybd',
    'ssc_z3ebd',
    'ssc_4xzxfx',
    'ssc_4xybd',
    'ssc_4xebd',
    'ssc_5xzxfx',
    'ssc_5xybd',
    'ssc_5xebd',
    'ssc_5xsbd',
    'ssc_q2dxds',
    'ssc_h2dxds',
    'ssc_q3dxds',
    'ssc_h3dxds',
    'pk10_dwd',
    'pk10_q5zxfx',
    'pk10_q4zxfx',
    'pk10_q3zxfx',
    'pk10_q2zxfx',
    'pk10_q1zxfx',
    'pk10_gyhz',
    'kl10_rx2',
    'kl10_rx3',
    'kl10_rx4',
    'kl10_rx5',
    'kl10_rx6',
    'kl10_rx7',
    'kl10_rx8',
    'kl10_q1zxfx',
    'kl10_q2zxfx',
    'kl10_q3zxfx',
    'kl10_q2zuxfx',
    'kl10_q3zuxfx',
    'k3_hz',
    'k3_3thdx',
    'k3_3bth',
    'k3_2thfx',
    'k3_2thdx',
    'k3_2bth',
    'k3_3thtx',
    'k3_3lhtx',
    '11x5_dwd',
    '11x5_rx2',
    '11x5_rx3',
    '11x5_rx4',
    '11x5_rx5',
    '11x5_rx6',
    '11x5_rx7',
    '11x5_rx8',
    '11x5_q2zxfx',
    '11x5_q3zxfx',
    '11x5_q2zuxfx',
    '11x5_q3zuxfx',
    'xglhc_tmzx',
    'xglhc_tmlm',
    'xglhc_zmrx',
    'xglhc_zmz1t',
    'xglhc_zmz1lm',
    'xglhc_zmz2t',
    'xglhc_zmz2lm',
    'xglhc_zmz3t',
    'xglhc_zmz3lm',
    'xglhc_zmz4t',
    'xglhc_zmz4lm',
    'xglhc_zmz5t',
    'xglhc_zmz5lm',
    'xglhc_zmz6t',
    'xglhc_zmz6lm',
    'xglhc_lm3qz',
    'xglhc_lm2qz',
    'xglhc_lm3z2',
    'xglhc_lm2z1',
    'xglhc_lmtc',
    'xglhc_tmbb',
    'xglhc_sxtx',
    'xglhc_sx1x',
    'xglhc_wstmtw',
    'xglhc_ws2wl',
    'xglhc_ws3wl',
    'xglhc_ws4wl',
    'xglhc_bz5',
    'xglhc_bz6',
    'xglhc_bz7',
    'xglhc_bz8',
    'xglhc_bz9',
    'xglhc_bz10',
  ];

  /// 返回彩种 实务
  static StyleManagerIMPL of(String str ,List<dynamic> lotPlayList) {

    List<String> temp = getPlayEn(lotPlayList);
    if (str.contains("ssc")) return Stylessc.of(str ,temp);
    if (str.contains("11x5")) return Style11x5.of(str ,temp);
    if (str.contains("pk10")) return Stylepk10.of(str ,temp);
    if (str.contains("kl10")) return Stylekl10.of(str);
    if (str.contains("lhc")) return Stylexglhc.of(str ,temp);
    if (str.contains("k3")) return Stylek3.of(str ,temp);
  }

  static List<String> getPlayEn(List<dynamic> lotPlayList) {
    List<String> temp = [] ;
    if(lotPlayList!=null){
     temp = lotPlayList.map((f)=>f['playEn'].toString()).toList();
    }
    if(temp==null||temp.length<1)
      temp = playEns ;
    return temp;
  }
}
