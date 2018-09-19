class DateHelper {
  static String invoke(num mill) {
    mill = mill /1000;
   int sec = (mill % 60).toInt();
   num secSup = mill / 60;
   int min = (secSup % 60 ).toInt();
   num minSup = secSup /60 ;
   int hour = (minSup ).toInt();
    return (hour > 9 ? "${hour}" : "0${hour}") +
        ":" +
        (min > 9 ? "${min}" : "0${min}") +
        ":" +
        (sec > 9 ? "${sec}" : "0${sec}");
  }
}
