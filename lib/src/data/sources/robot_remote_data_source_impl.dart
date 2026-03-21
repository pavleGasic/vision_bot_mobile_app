import 'dart:async';

import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/resources/consts/ros_message_types.dart';
import 'package:vision_bot_mobile_app/core/services/rosbridge/ros_bridge_client.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_state.dart';
import 'package:vision_bot_mobile_app/src/data/models/camera_data_model.dart';
import 'package:vision_bot_mobile_app/src/data/models/heartbeat_message_model.dart';
import 'package:vision_bot_mobile_app/src/data/models/ros_connection_state_model.dart';
import 'package:vision_bot_mobile_app/src/data/models/twist_model.dart';
import 'package:vision_bot_mobile_app/src/data/sources/robot_remote_data_source.dart';

class RobotRemoteDataSourceImpl implements RobotRemoteDataSource {
  RobotRemoteDataSourceImpl({required this.rosBridgeClient});

  final RosBridgeClient rosBridgeClient;

  final String heartbeatTopic = '/heartbeat';
  final String driveTopic = '/diff_drive_controller/cmd_vel_unstamped';
  final String cameraDataTopic = '/camera/image_raw/compressed';

  @override
  Future<void> connect() async {
    try {
      await rosBridgeClient.connect();
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }

  @override
  Stream<RosConnectionStateModel> get connectionStream =>
      rosBridgeClient.streamController.stream.map(_mapState);

  @override
  Stream<HeartbeatMessageModel> subscribeHeartbeat() {
    try {
      return rosBridgeClient
          .subscribe(topic: heartbeatTopic)
          .map(HeartbeatMessageModel.fromMap);
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }

  @override
  void publishRobotVelocity({
    required Vector3 linear,
    required Vector3 angular,
  }) {
    try {
      final message = TwistModel(angular: angular, linear: linear);
      rosBridgeClient.publish(
        topic: driveTopic,
        message: message.toJson(),
        advertiseMsgType: RosMessageTypes.twistMessage,
      );
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }

  @override
  Stream<CameraDataModel> subscribeCamera() {
    try {
      return rosBridgeClient
          .subscribe(topic: cameraDataTopic)
          .map(CameraDataModel.fromMap);
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }

  @override
  void unsubscribeCamera() {
    try {
      rosBridgeClient
          .unsubscribe(topic: cameraDataTopic);
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }

  RosConnectionStateModel _mapState(WebSocketState state) {
    switch (state) {
      case WebSocketState.connected:
        return RosConnectionStateModel.connected;

      case WebSocketState.disconnected:
        return RosConnectionStateModel.disconnected;

      case WebSocketState.loading:
        return RosConnectionStateModel.loading;

      case WebSocketState.failed:
        return RosConnectionStateModel.failed;
    }
  }
}
