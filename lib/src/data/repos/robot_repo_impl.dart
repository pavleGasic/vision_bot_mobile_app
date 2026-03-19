import 'package:dartz/dartz.dart';
import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/errors/failures.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/data/models/ros_connection_state_model.dart';
import 'package:vision_bot_mobile_app/src/data/sources/robot_remote_data_source.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/ros_connection_state.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class RobotRepoImpl implements RobotRepo {
  const RobotRepoImpl(this._remoteDataSource);

  final RobotRemoteDataSource _remoteDataSource;

  @override
  ResultObject<Stream<RosConnectionState>> rosConnect() {
    try {
      _remoteDataSource.connect();
      final connectionStream = _remoteDataSource.connectionStream;
      return Right(connectionStream.map(_mapState));
    } on WebSocketException catch (e) {
      return Left(
        WebSocketFailure(
          message: e.message,
          statusCode: e.message,
        ),
      );
    }
  }

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

  @override
  ResultObject<Twist> publishVelocity({
    required Vector3 angular,
    required Vector3 linear,
  }) {
    try {
      _remoteDataSource.publishRobotVelocity(linear: linear, angular: angular);
      return Right(
        Twist(
          angular: angular,
          linear: linear,
        ),
      );
    } on WebSocketException catch (e) {
      return Left(
        WebSocketFailure(
          message: e.message,
          statusCode: e.message,
        ),
      );
    }
  }

  RosConnectionState _mapState(RosConnectionStateModel state) {
    switch (state) {
      case RosConnectionStateModel.connected:
        return RosConnectionState.connected;

      case RosConnectionStateModel.disconnected:
        return RosConnectionState.disconnected;

      case RosConnectionStateModel.loading:
        return RosConnectionState.loading;

      case RosConnectionStateModel.failed:
        return RosConnectionState.failed;
    }
  }
}
