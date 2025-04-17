import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

class GSheetHelper {
  static const _spreadsheetId = '1xn47aOwk5itphmI08XoI1gSwluwW-KLNV2-UBeeqsoE';
  static const _sheetTitle = 'Main';

  late Worksheet _sheet;

  Future<void> init() async {
    try{
    final credentials = await rootBundle.loadString('assets/creds.json');
    final gSheets = GSheets(credentials);
    final spreadsheet = await gSheets.spreadsheet(_spreadsheetId);
    _sheet = spreadsheet.worksheetByTitle(_sheetTitle)!;
    } catch(e){
      log(e.toString(), name: "INIT>");
    }
  }

  Future<void> logData({
    required String customerId,
    required String serialNumber,
    required String hashId,
    required String startDate,
    required String endDate,
    required String customerName,
    required String amount,
  }) async {
    await _sheet.values.appendRow([
      DateFormat("dd-MM-yyyy").format(DateTime.now()),
      startDate,
      endDate,
      customerId,
      customerName,
      amount,
      serialNumber,
      hashId,
    ]);
  }
}
