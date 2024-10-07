
class OccasionChecker {
  final DateTime date;

  OccasionChecker(this.date);

  // Function to check if the date is an occasion
  String checkOccasion() {
    if (isNewYear()) {
      return 'New Year';
    } else if (isAshWednesday()) {
      return 'Ash Wednesday';
    } else if (isMaundyThursday()) {
      return 'Maundy Thursday';
    } else if (isGoodFriday()) {
      return 'Good Friday';
    } else if (isPalmSunday()) {
      return 'Palm Sunday';
    } else if (isEaster()) {
      return 'Easter';
    }else if (isChristmas()) {
      return 'Christmas';
    } else {
      return 'Not an occasion';
    }
  }

  bool isNewYear() {
    return date.month == 1 && date.day == 1;
  }

  bool isAshWednesday() {
    return _getEasterDate().subtract(Duration(days: 46)).isSameDay(date);
  }

  bool isMaundyThursday() {
    return _getEasterDate().subtract(Duration(days: 3)).isSameDay(date);
  }

  bool isGoodFriday() {
    return _getEasterDate().subtract(Duration(days: 2)).isSameDay(date);
  }

  bool isPalmSunday() {
    return _getEasterDate().subtract(Duration(days: 7)).isSameDay(date);
  }

  bool isEaster() {
    return _getEasterDate().isSameDay(date);
  }


  bool isChristmas() {
    return (date.month == 12 && date.day >= 20 && date.day <= 25);
  }

  DateTime _getEasterDate() {
    // Calculate the date of Easter for the given year
    int year = date.year;
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 16;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 16 + l) ~/ 25;
    int month = 3 + (h + 90 - m) ~/ 25;
    int day = (h + l - 31 * (month ~/ 4)) + 1;

    return DateTime(year, month, day);
  }
}

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

// Function to check the occasion
String checkDateOccasion(DateTime dateToCheck) {
  var checker = OccasionChecker(dateToCheck);
  return checker.checkOccasion();
}

