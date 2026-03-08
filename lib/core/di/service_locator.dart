import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:vision_bot_mobile_app/core/environment.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_client.dart';
import 'package:vision_bot_mobile_app/src/home/data/repos/heartbeat_repo_impl.dart';
import 'package:vision_bot_mobile_app/src/home/data/sources/heartbeat_remote_data_source.dart';
import 'package:vision_bot_mobile_app/src/home/data/sources/heartbeat_remote_data_source_impl.dart';
import 'package:vision_bot_mobile_app/src/home/domain/repos/heartbeat_repo.dart';
import 'package:vision_bot_mobile_app/src/home/domain/usecases/heartbeat.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  await initializeEnvironment();
  initializeWebsocketClient();
  initializeRemoteDataSources();
}

Future<void> initializeEnvironment() async {
  await dotenv.load(fileName: 'env/.ros.env');
}

void initializeWebsocketClient() {
  final uri = '${Environment.wsBaseUrl}:${Environment.wsBasePort}';

  serviceLocator.registerLazySingleton<WebSocketClient>(
    () => WebSocketClient(
      uri: uri,
    ),
  );
}

void initializeRemoteDataSources() {
  serviceLocator
    ..registerLazySingleton<HeartbeatRemoteDataSource>(
      () => HeartbeatRemoteDataSourceImpl(wsClient: serviceLocator()),
    )
    ..registerLazySingleton<HeartbeatRepo>(
      () => HeartbeatRepoImpl(serviceLocator()),
    )
    ..registerLazySingleton(() => Heartbeat(serviceLocator()));
}
