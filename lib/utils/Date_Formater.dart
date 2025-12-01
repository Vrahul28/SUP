import 'package:intl/intl.dart';

String formatDate(String apiDate) {
  DateTime parsedDate = DateTime.parse(apiDate); // Parse the API date string
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a'); // Set desired format
  return formatter.format(parsedDate);
}

