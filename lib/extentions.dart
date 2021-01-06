import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension DateTimeFormatter on DateTime {
  String ddMMMyyyy() {
    return DateFormat('dd-MMM-yyyy').format(this);
  }

  String ddMMMyyyyHHmmss() {
    return DateFormat('dd-MMM-yyyy_HH_mm_ss').format(this);
  }

  String ddMMMyyyyHHmm() {
    return DateFormat('dd-MMM-yyyy').add_jm().format(this);
  }
}

extension DoubleFormatter on double {
  String formatAmount() {
    var f = new NumberFormat("##,###.00");
    if (this != null) {
      return f.format(this);
    } else {
      return "";
    }
  }

  String formatSymbolAmount(String symbol) {
    var f = new NumberFormat("##,###.00");
    if (this != null) {
      return symbol + " " + f.format(this);
    } else {
      return "";
    }
  }

  String formatRate() {
    var f = new NumberFormat("##,###.00");
    if (this != null) {
      return f.format(this);
    } else {
      return "No Rate";
    }
  }
}
