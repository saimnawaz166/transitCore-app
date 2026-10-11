import 'package:dio/dio.dart';

/// Pulls a human-readable message out of a Laravel error response —
/// the first validation error if there's a field-level `errors` map,
/// otherwise the top-level `message`. Returns null if the response
/// doesn't have either shape (e.g. a network error with no response at all).
String? extractApiErrorMessage(DioException e) {
  final data = e.response?.data;
  if (data is Map) {
    final errors = data['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final first = errors.values.first;
      if (first is List && first.isNotEmpty) return first.first.toString();
    }
    if (data['message'] is String) return data['message'] as String;
  }
  return null;
}
