import 'package:intl/intl.dart';

DateTime get empatyDate => DateTime.parse("1912-01-30");

DateTime selectedDate = DateTime.now();

extension DateTimeUtils on DateTime {
  String get formatDateTime => DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDate);
}
