import 'package:equatable/equatable.dart';

import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode, this.code});

  final String message;
  final dynamic statusCode;
  final String? code;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class WebSocketFailure extends Failure {
  const WebSocketFailure({
    required super.message,
    required super.statusCode,
    super.code,
  });

  WebSocketFailure.fromException(WebSocketException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
