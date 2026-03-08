import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/home/domain/entities/heartbeat_message.dart';

abstract class HeartbeatRepo {
  const HeartbeatRepo();

  ResultObject<Stream<HeartbeatMessage>> subscribeHeartbeat();
}
