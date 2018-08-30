
class DateHelper{
  static String invoke(num mill){
    var date = new DateTime.fromMillisecondsSinceEpoch(mill);
    return "${date.hour}:${date.minute}:${date.millisecond}";
  }
}
