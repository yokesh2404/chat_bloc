import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class FunctionsHelper {
  FunctionsHelper._privateConstructor();

  static final FunctionsHelper getInstance =
      FunctionsHelper._privateConstructor();

  factory FunctionsHelper() {
    return getInstance;
  }

  bool isUrl(String string) {
    final urlPattern = RegExp(r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$');
    return urlPattern.hasMatch(string);
  }

  bool validateEmail(String email) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    final regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    const pattern = r'^\d+(?:\d+)?$';

    final regx = RegExp(pattern);

    return regx.hasMatch(phoneNumber);
  }

  bool isStrongPassword(String password) {
    // Define password criteria using regular expressions
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp digitRegex = RegExp(r'[0-9]');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (password.length < 8) {
      return false;
    }

    if (!uppercaseRegex.hasMatch(password)) {
      return false;
    }

    if (!lowercaseRegex.hasMatch(password)) {
      return false;
    }

    if (!digitRegex.hasMatch(password)) {
      return false;
    }
    if (!specialCharRegex.hasMatch(password)) {
      return false;
    }

    return true; // Password meets all criteria
  }

  String getDateFormate(DateTime date, String formate) {
    DateFormat dateFormat = DateFormat(formate);
    var result = dateFormat.format(date);
    return result;
  }

  getUTCDateformat(String date, String formate) {
    String dateString = date;
    DateFormat format = DateFormat(formate);
    DateTime dateTime = format.parse(dateString);

    return dateTime;
  }

  getTimeFromString(String time, String format) {
    // String timeString = "08:00 PM";'HH:mm'
    DateTime parsedTime = DateFormat.jm().parse(time);
    String formattedTime = DateFormat(format).format(parsedTime);

    return formattedTime;
  }

  String capitalizeString(String? input) {
    if (input == null || input.isEmpty) {
      return input!;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  String getDuration(int duration) {
    int hours = duration ~/ 60;
    int minutes = duration % 60;

    return hours == 0
        ? "${minutes}M"
        : minutes > 0
            ? "${hours}Hr ${minutes}M"
            : "${hours}Hr";
  }

  String replaceAll(
      {required String content,
      required String existing,
      required String replaceContent}) {
    if (content.isNotEmpty) {
      return content.replaceAll(existing, replaceContent);
    }

    return "";
  }

  String removeHtmlTags(String htmlString) {
    final RegExp htmlTagRegExp = RegExp(r'<[^>]*>');

    String cleanedString = htmlString.replaceAll(htmlTagRegExp, '');

    return cleanedString;
  }

  List<String> convertHtmlTexttoPlainText(String content) {
    if (content.isNotEmpty) {
      var cleanString = removeHtmlTags(content);

      var splittedString = cleanString.split("//");

      splittedString.removeWhere((item) => item.isEmpty);

      return splittedString;
    }

    return [];
  }

  bool compareDates(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<T> loadJson<T>(
      String path, T Function(Map<String, dynamic>) fromJson) async {
    String jsonString = await rootBundle.loadString(path);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return fromJson(jsonMap);
  }

  bool nameValidation(String val) {
    if (val.isEmpty || val.length > 24) {
      return false;
    } else {
      return true;
    }
  }

  bool dropdonValidation(String? val) {
    return val != null && val.isNotEmpty;
  }

  bool validateEmailForm(String email) {
    try {
      // Regular expression pattern for email validation
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);
      // Test the email against the pattern
      List afterATList = email.split('@');
      var beforDot = afterATList[1].split('.');
      return regex.hasMatch(email) &&
          beforDot[0].length >= 4 &&
          afterATList.length == 2 &&
          afterATList[0].length > 1;
    } catch (e) {
      return false;
    }
  }

  T? enumFromString<T>(List<T> enumValues, String value) {
    return enumValues.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }

  double checkValueDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value.toString().isEmpty) {
      return 0.0;
    } else if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }

  String toStringAsFixed({dynamic value, required int fractionDigits}) {
    return formatNumberWithSeparator(
        checkValueDouble(value).toStringAsFixed(fractionDigits));
  }

  bool isAlphabetic(String input) {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(input);
  }

  bool isAlphabeticWithSpaces(String input) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(input);
  }

  bool isNumeric(String input) {
    final RegExp regex = RegExp(r'^\d+$');
    return regex.hasMatch(input);
  }

  // launchUrls(String uri, BuildContext context, {Uri? paramsUrl}) async {
  //   if (!await launchUrl(paramsUrl ?? Uri.parse(uri))) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Sorry,Cant launch this url!!!")));
  //   }
  // }

  String getErrorPnr(String query) {
    String result = "";
    final regExp = RegExp(r'pnr=([^&]+)&message');
    final match = regExp.firstMatch(query);

    if (match != null) {
      var pnrValue = match.group(1);
      print('PNR value: $pnrValue');
      result = "${pnrValue}";
    }

    return result;
  }

  // static validateCardNumber(String number) {
  //   if (number.isEmpty) {
  //     return "Please Enter Card Number";
  //   } else {
  //     if (getCardType(number) == null) {
  //       return "Please Enter Visa or Master Card Number";
  //     } else if (number.length != 22) {
  //       return "Please Enter Valid Card Number";
  //     }
  //   }
  //   return null;
  // }

  static validateExpDate(String value) {
    if (value.isEmpty) {
      return "Please Enter Card Expiry";
    } else {
      int? year;
      int month;
      // The value contains a forward slash if the month and year has been
      // entered.
      if (value.contains(new RegExp(r'(/)'))) {
        var split = value.split(new RegExp(r'(/)'));
        // The value before the slash is the month while the value to right of
        // it is the year.
        month = int.parse(split[0]);
        year = int.parse(split[1]);
        // if (split.length > 1) {
        //   year = int.parse(split[1]);
        // }
      } else {
        // Only the month was entered
        month = int.parse(value.substring(0, (value.length)));
        year = -1; // Lets use an invalid year intentionally
      }

      if ((month < 1) || (month > 12)) {
        // A valid month is between 1 (January) and 12 (December)
        return 'Expiry month is invalid';
      }

      if (year != -1) {
        var fourDigitsYear = convertYearTo4Digits(year);
        if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
          // We are assuming a valid should be between 1 and 2099.
          // Note that, it's valid doesn't mean that it has not expired.
          return 'Expiry year is invalid';
        }

        if (!hasDateExpired(month, year)) {
          return "Card has expired";
        }
      } else {
        return "Please Enter Valid Expiry Date";
      }
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static validateCVV(String cvv) {
    if (cvv.isEmpty) {
      return "Please Enter Number Behind the Card";
    } else {
      if (!(cvv.length == 3 || cvv.length == 4)) {
        return "Please Enter Number Behind the Card";
      }
    }
    return null;
  }

  // static getCardType(String number) {
  //   if (number.startsWith(RegExp(r'^4'))) {
  //     return CardTypes.Visa;
  //   } else if (number.startsWith(RegExp(r'^(5[1-5]|2[2-7])'))) {
  //     return CardTypes.Mastercard;
  //   } else {
  //     return null;
  //   }
  // }

  static validateCardName(String val) {
    if (!FunctionsHelper().nameValidation(val)) {
      return "Please Enter Valid Name On Card";
    }

    return null;
  }

  String formatNumberWithSeparator(dynamic number) {
    // Convert the number to a string
    number = number.toString();
    String numberString = double.parse(number).toStringAsFixed(2);

    // Split the number into integer and decimal parts
    List<String> parts = numberString.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Reverse the integer part to handle grouping from the right
    String reversedIntegerPart = integerPart.split('').reversed.join('');

    // Add a comma after every three digits
    String separatedReversedInteger = '';
    for (int i = 0; i < reversedIntegerPart.length; i++) {
      if (i > 0 && i % 3 == 0) {
        separatedReversedInteger += ',';
      }
      separatedReversedInteger += reversedIntegerPart[i];
    }

    // Reverse again to get the correct order
    String formattedIntegerPart =
        separatedReversedInteger.split('').reversed.join('');

    return '$formattedIntegerPart.$decimalPart';
  }
}
