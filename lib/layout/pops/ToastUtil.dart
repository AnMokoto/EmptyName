import 'package:fluttertoast/fluttertoast.dart';

//// toast
class ToastUtil {
  static void show(String msg) {
    Fluttertoast.showToast(
        msg: msg ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
  }
}
