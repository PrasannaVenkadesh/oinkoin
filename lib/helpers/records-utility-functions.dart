import 'dart:collection';
import 'dart:developer';
import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';
import 'package:piggybank/models/record.dart';
import 'package:piggybank/models/records-per-day.dart';

import '../services/service-config.dart';


List<RecordsPerDay> groupRecordsByDay(List<Record?> records) {
  /// Groups the record in days using the object MovementsPerDay.
  /// It returns a list of MovementsPerDay object, containing at least 1 movement.
  var movementsGroups = groupBy(records, (dynamic records) => records.date);
  Queue<RecordsPerDay> movementsPerDay = Queue();
  movementsGroups.forEach((k, groupedMovements) {
    if (groupedMovements.isNotEmpty) {
      DateTime? groupedDay = groupedMovements[0]!.dateTime;
      movementsPerDay.addFirst(new RecordsPerDay(groupedDay, records: groupedMovements));
    }
  });
  var movementsDayList = movementsPerDay.toList();
  movementsDayList.sort((b, a) => a.dateTime!.compareTo(b.dateTime!));
  return movementsDayList;
}

final defaultNumberFormat = new NumberFormat("#######.0#", "en_US");

String getCurrencyValueString(double? value) {
  if (value == null) return "";
  bool hasNotDecimalPart = value % 1 == 0;
  NumberFormat numberFormat;
  try {
    Locale myLocale = I18n.locale;
    numberFormat = new NumberFormat.currency(
        locale: myLocale.toString(), symbol: "", decimalDigits: hasNotDecimalPart ? 0 : 2);
  } on Exception catch (_) {
    numberFormat = defaultNumberFormat;
  }
  return numberFormat.format(value);
}

AssetImage getBackgroundImage() {
  if (!ServiceConfig.isPremium) {
    return AssetImage('assets/background.jpg');
  } else {
    try {
      var now = DateTime.now();
      String month = now.month.toString();
      return AssetImage('assets/bkg_' + month + '.jpg');
    } on Exception catch (_) {
      return AssetImage('assets/background.jpg');
    }
  }
}
