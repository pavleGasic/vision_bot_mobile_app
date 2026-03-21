import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:vision_bot_mobile_app/core/environment.dart';
import 'package:vision_bot_mobile_app/core/services/rosbridge/ros_bridge_client.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_client.dart';
import 'package:vision_bot_mobile_app/src/data/repos/robot_repo_impl.dart';
import 'package:vision_bot_mobile_app/src/data/sources/robot_remote_data_source.dart';
import 'package:vision_bot_mobile_app/src/data/sources/robot_remote_data_source_impl.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/heartbeat.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/publish_velocity.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/ros_connect.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/subscribe_camera.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/unsubscribe_camera.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  await initializeEnvironment();
  initializeRosBridgeCommunication();
  initializeRemoteDataSources();
}

Future<void> initializeEnvironment() async {
  await dotenv.load(fileName: 'env/.ros.env');
}

void initializeRosBridgeCommunication() {
  final uri = '${Environment.wsBaseUrl}:${Environment.wsBasePort}';

  serviceLocator
    ..registerLazySingleton<WebSocketClient>(
      () => WebSocketClient(uri: uri),
    )
    ..registerLazySingleton<RosBridgeClient>(
      () => RosBridgeClient(webSocketClient: serviceLocator()),
    );
}

void initializeRemoteDataSources() {
  serviceLocator
    ..registerLazySingleton<RobotRemoteDataSource>(
      () => RobotRemoteDataSourceImpl(rosBridgeClient: serviceLocator()),
    )
    ..registerLazySingleton<RobotRepo>(
      () => RobotRepoImpl(serviceLocator()),
    )
    ..registerLazySingleton(() => UnsubscribeCamera(serviceLocator()))
    ..registerLazySingleton(() => SubscribeCamera(serviceLocator()))
    ..registerLazySingleton(() => PublishVelocity(serviceLocator()))
    ..registerLazySingleton(() => Heartbeat(serviceLocator()))
    ..registerLazySingleton(() => RosConnect(serviceLocator()));
}
