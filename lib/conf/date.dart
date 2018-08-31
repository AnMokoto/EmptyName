class DateHelper {
  static String invoke(num mill) {
    var date =
        new DateTime.fromMillisecondsSinceEpoch(mill.toInt(), isUtc: true);
    //return "${date.hour}:${date.minute}:${date.second}";
    return (date.hour > 9 ? "${date.hour}" : "0${date.hour}") +
        ":" +
        (date.minute > 9 ? "${date.minute}" : "0${date.minute}") +
        ":" +
        (date.second > 9 ? "${date.second}" : "0${date.second}");
  }
}
