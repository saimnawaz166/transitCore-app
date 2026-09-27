import 'package:intl/intl.dart';

abstract final class Formatters {
  static String date(DateTime dt) => DateFormat('MMM d, yyyy').format(dt);

  static String time(DateTime dt) => DateFormat('h:mm a').format(dt);

  static String dateTime(DateTime dt) => '${date(dt)} · ${time(dt)}';

  static String relativeDay(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final diff = today.difference(target).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff == -1) return 'Tomorrow';
    return date(dt);
  }

  static String currency(double amount, String currencyCode) =>
      '${amount.toStringAsFixed(2)} $currencyCode';

  static String relativeTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
