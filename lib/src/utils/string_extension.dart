import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  /// Format the date to a named format
  ///  E.g `"20-03-2020T02:00:00Z".toDateFormat('dd-MMMM-yyyy')` => `"20-Mar-2020"`
  String toDateFormat([String format = "yyyy-MM-dd"]) {
    return DateFormat(format).format(DateTime.parse(this));
  }

  String get capitalizeFirst => this[0].toUpperCase() + substring(1).toLowerCase();

  bool get isEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  String toISO() {
    final dateformat = DateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'");
    final parsed = dateformat.format(DateTime.parse(this));
    return parsed;
  }

  String compactStringMiddle([int maxLength = 60]) {
    if (length > maxLength) {
      int startLength = (maxLength / 2).floor();
      int endLength = (maxLength / 2).ceil();

      return '${substring(0, startLength)}......${substring(length - endLength)}';
    }
    return this;
  }

  String toTimeAgo({bool deatiled = false}) {
    DateTime date = DateTime.parse(this).toLocal();
    final now = DateTime.now().toLocal();
    final difference = now.difference(date);
    int inSeconds = difference.inSeconds;
    int inMinutes = difference.inMinutes;
    int inHours = difference.inHours;
    if (inSeconds < 60) return 'now';
    if (inMinutes <= 60) return '${inMinutes}m';
    if (inHours <= 24) return '${inHours}h';
    return toDateFormat('MMM dd');
  }

  String toDaysLeft() {
    int daysLeft = DateTime.parse(this).difference(DateTime.now()).inDays;
    if (daysLeft == 0) return 'Today';
    if (daysLeft == 1) return 'Tomorrow';
    return '$daysLeft days left';
  }

  void openLink({LaunchMode? mode}) async {
    final Uri path = Uri.parse(this);
    await launchUrl(path, mode: mode ?? LaunchMode.externalApplication);
  }

  void openEmail({LaunchMode? mode}) async {
    final Uri path = Uri(scheme: 'mailto', path: this);
    await launchUrl(path, mode: mode ?? LaunchMode.externalApplication);
  }

  void callToPhone({LaunchMode? mode}) async {
    final Uri path = Uri(scheme: 'tel', path: this);
    await launchUrl(path, mode: mode ?? LaunchMode.externalApplication);
  }

  DecodedJWT? decodeJWTAndGetUserId() {
    final splitToken = split(".");
    if (splitToken.length != 3) return null;
    try {
      final payloadBase64 = splitToken[1];
      final normalizedPayload = base64.normalize(payloadBase64);
      final payload = utf8.decode(base64.decode(normalizedPayload));
      final result = Map.from(json.decode(payload));
      return DecodedJWT(result["sub"], result["user_type"], result["phone_number"]);
    } catch (error) {
      return null;
    }
  }
}

class DecodedJWT {
  final String id;
  final String type;
  final String phone;

  const DecodedJWT(this.id, this.type, this.phone);

  @override
  String toString() => 'DecodedJWT(id: $id, type: $type, phone: $phone)';

  @override
  bool operator ==(covariant DecodedJWT other) {
    if (identical(this, other)) return true;
    return other.id == id && other.type == type && other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ phone.hashCode;
}

extension ExtT<T> on List<T> {
  T? singleWhereOrNull(bool Function(T element) test) {
    var matchingElements = where(test).toList();
    if (matchingElements.length == 1) return matchingElements.first;
    return null;
  }
}

extension DateTimeTimezoneExtension on DateTime {
  String toIsoWithTimezone() {
    // Get local time zone offset
    // Duration offset = timeZoneOffset;
    // String offsetSign = offset.isNegative ? "-" : "+";
    // String hoursOffset = offset.inHours.abs().toString().padLeft(2, '0');
    // String minutesOffset = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');

    // Append the offset to the ISO 8601 string
    return "${DateTime.now().toIso8601String()}Z";
  }
}
