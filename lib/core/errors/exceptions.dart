import 'package:equatable/equatable.dart';

class WebSocketException extends Equatable implements Exception {
  const WebSocketException({
    required this.message,
    required this.statusCode,
    this.code,
  });

  final String message;
  final int statusCode;
  final String? code;

  @override
  List<Object?> get props => [message, statusCode, code];
}
