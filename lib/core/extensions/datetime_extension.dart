extension DateTimeExtension on DateTime {
  String toDayMonthYearString() {
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    String month = this.month < 10 ? "0${this.month}" : this.month.toString();
    String year = this.year.toString();

    return "$day/$month/$year";
  }

  String toDateTimeString() {
    String day = this.day < 10 ? "0${this.day}" : this.day.toString();
    String month = monthName();
    String year = this.year.toString();
    String hour = this.hour < 10 ? "0${this.hour}" : this.hour.toString();
    String minute = this.minute < 10 ? "0${this.minute}" : this.minute.toString();

    return "$day $month $year - $hour:$minute";
  }

  String toMonthNameFullDate() {
    String day = this.day.toString();
    String month = monthName();
    String year = this.year.toString();

    return "$day $month $year";
  }

  String monthName() {
    switch (month) {
      case 1:
        return "Ocak";
      case 2:
        return "Şubat";
      case 3:
        return "Mart";
      case 4:
        return "Nisan";
      case 5:
        return "Mayıs";
      case 6:
        return "Haziran";
      case 7:
        return "Temmuz";
      case 8:
        return "Ağustos";
      case 9:
        return "Eylül";
      case 10:
        return "Ekim";
      case 11:
        return "Kasım";
      case 12:
        return "Aralık";
      default:
        return "";
    }
  }
}
