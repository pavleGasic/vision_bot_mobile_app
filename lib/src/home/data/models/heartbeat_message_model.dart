import 'dart:convert';

import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/home/domain/entities/heartbeat_message.dart';

class HeartbeatMessageModel extends HeartbeatMessage {
  const HeartbeatMessageModel({
    required super.message,
    required super.isAlive,
  });

  factory HeartbeatMessageModel.fromJson(String source) =>
      HeartbeatMessageModel.fromMap(jsonDecode(source) as DataMap);

  HeartbeatMessageModel.fromMap(DataMap map)
    : super(
        message: map['data'] as String,
        isAlive: map['data'] != null && map['data'] == 'Alive',
      );
}
