import 'package:meta/meta.dart';

@immutable
abstract class NetworkException implements Exception {}

base class RemoteDataProviderException implements NetworkException {
  const RemoteDataProviderException({this.message, this.statusCode});

  /// Possible reason for the exception
  final String? message;

  /// The status code of the response (if any)
  final int? statusCode;

  @override
  String toString() => 'RemoteDataProviderException('
      'message: $message,'
      'statusCode: $statusCode'
      ')';
}
