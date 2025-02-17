// ignore: file_names
import 'package:intl/intl.dart';

class DateTimeUtil {
  // Method to format time in 'HH:mm' format
  static String formatTimeShort(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('HH:mm').format(date);
  }

  // Method to format timestamp in 'HH:mm' format
  static String formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('HH:mm').format(dateTime); // e.g., "14:30"
  }

  // You can add more methods if needed, like formatting for different formats
}
