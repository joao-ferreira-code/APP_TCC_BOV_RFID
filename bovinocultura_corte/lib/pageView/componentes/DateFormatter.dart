
import 'package:intl/intl.dart';

class DateFormatter {

  static String formateDate = "dd/MM/yyyy";
  static String formateDateTime = "dd/MM/yyyy HH:mm:ss";

//============================================================================//

  static DateTime? parse( {String? value} ) {
    return value!= null?DateFormat(formateDate).parse(value):null;
  }

  static String format({DateTime? dateTime} ) {
    return dateTime!= null?DateFormat(formateDate).format(dateTime):"";
  }

//============================================================================//

  static DateTime? parseTime( {String? value} ) {
    return value!= null?DateFormat(formateDateTime).parse(value):null;
  }

  static String formatTime( {DateTime? dateTime} ) {
    return dateTime!= null?DateFormat(formateDateTime).format(dateTime):"";
  }

//============================================================================//

}