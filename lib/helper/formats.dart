import "package:basic_utils/basic_utils.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class Formats {
  static String coalesce(String? value, {String? defaultString}) {
    return StringUtils.isNotNullOrEmpty(value) ? value! : defaultString ?? "N/A";
  }

  static String getInitialText(String text) {
    List<String> splitText = text.split(" ");

    if (splitText.length == 1) {
      return splitText[0][0].toUpperCase();
    } else {
      return splitText[0][0].toUpperCase() + splitText[1][0].toUpperCase();
    }
  }

  static num tryParseNumber(dynamic value) {
    if (value != null) {
      if (value is String) {
        try {
          return NumberFormat("", "id").parse(value);
        } catch (ignored) {
          return num.tryParse(value) ?? 0;
        }
      } else if (value is int) {
        return value;
      } else if (value is double) {
        return value;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  static bool tryParseBool(dynamic value) {
    if (value != null) {
      if (value is String) {
        return bool.tryParse(value) ?? false;
      } else if (value is int) {
        return value == 1;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static String dateAlternative({
    DateTime? dateTime,
    String? defaultString,
  }) {
    if (dateTime != null) {
      return DateFormat("d MMM ''yy", "id").format(dateTime.toLocal());
    } else {
      return defaultString ?? "N/A";
    }
  }

  static String dateTimeAlternative({
    DateTime? dateTime,
    String? defaultString,
  }) {
    if (dateTime != null) {
      return DateFormat("d MMM ''yy HH:mm", "id").format(dateTime.toLocal());
    } else {
      return defaultString ?? "N/A";
    }
  }

  static String timeAlternative({
    TimeOfDay? timeOfDay,
    String? defaultString,
  }) {
    if (timeOfDay != null) {
      return const DefaultMaterialLocalizations().formatTimeOfDay(timeOfDay, alwaysUse24HourFormat: true);
    } else {
      return defaultString ?? "N/A";
    }
  }

  static TimeOfDay parseTime(String string) {
    return TimeOfDay(hour: int.parse(string.split(":")[0]), minute: int.parse(string.split(":")[1]));
  }

  static DateTime parseToDate(String string) {
    final DateFormat formatter = DateFormat("d MMM ''yy", "id");

    return formatter.parse(string);
  }

  static DateTime parseToDateTime(String string) {
    final DateFormat formatter = DateFormat("d MMM ''yy HH:mm");

    return formatter.parse(string);
  }

  static DateTime parseToCommonDate(String string) {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");

    return formatter.parse(string);
  }

  static String convertToAgo(DateTime? dateTime){
    if (dateTime != null) {
      Duration diff = DateTime.now().difference(dateTime);

      if(diff.inDays >= 1){
        if(diff.inDays >= 31) {
          double inMonth = diff.inDays / 30;
          if(inMonth >= 12) {
            double inYear = inMonth / 12;
            return '${inYear.floor()} tahun lalu';
          }
          return '${inMonth.floor()} bulan lalu';
        } else {
          return '${diff.inDays} hari lalu';
        }
      } else if(diff.inHours >= 1){
        return '${diff.inHours} jam lalu';
      } else if(diff.inMinutes >= 1){
        return '${diff.inMinutes} menit lalu';
      } else {
        return 'baru saja';
      }
    }

    return "N/A";
  }

  static String convertToForward(DateTime dateTime) {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (dateTime.difference(now).inDays == 1) {
      return "Besok";
    } else if (dateTime.difference(now).inDays == 0) {
      return "Hari ini";
    } else if (dateTime.difference(now).inDays < 0) {
      return "Sudah lewat";
    } else if (dateTime.difference(now).inDays > 1) {
      return "Yang akan datang";
    } else {
      return "null";
    }
  }
}
