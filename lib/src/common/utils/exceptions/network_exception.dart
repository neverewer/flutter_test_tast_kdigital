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

//if there is no internet connection
final class ConnectionException extends RemoteDataProviderException {
  /// {@macro connection_exception}
  const ConnectionException({super.message, super.statusCode});

  @override
  String toString() => 'ConnectionException('
      'message: $message,'
      'statusCode: $statusCode'
      ')';
}
