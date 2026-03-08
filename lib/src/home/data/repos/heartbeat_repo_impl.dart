import 'package:dartz/dartz.dart';
import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/errors/failures.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/home/data/sources/heartbeat_remote_data_source.dart';
import 'package:vision_bot_mobile_app/src/home/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/home/domain/repos/heartbeat_repo.dart';

class HeartbeatRepoImpl implements HeartbeatRepo {
  const HeartbeatRepoImpl(this._remoteDataSource);

  final HeartbeatRemoteDataSource _remoteDataSource;

  @override
  ResultObject<Stream<HeartbeatMessage>> subscribeHeartbeat() {
    try {
      final heartbeatStream = _remoteDataSource.subscribeHeartbeat();
      return Right(heartbeatStream);
    } on WebSocketException catch (e) {
      return Left(
        WebSocketFailure(
          message: e.message,
          statusCode: e.message,
        ),
      );
    }
  }
}
