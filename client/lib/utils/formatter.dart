import 'package:intl/intl.dart';

String formatDate(String unformattedDate) {
  final String year = unformattedDate.split('-')[0];
  final String month = unformattedDate.split('-')[1];
  final String date = unformattedDate.split('-')[2].substring(0, 2);

  const monthMap = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };

  String result = "$date ${monthMap[month]} $year";

  return result;
}

String formatToIDR(double amount) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ');
  return formatter.format(amount);
}
