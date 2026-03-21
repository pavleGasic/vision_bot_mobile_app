import 'dart:convert';

import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/camera_data.dart';

class CameraDataModel extends CameraData {
  const CameraDataModel({required super.data});

  CameraDataModel.fromMap(DataMap map)
    : super(data: base64Decode(map['data'] as String));

  factory CameraDataModel.fromJson(String source) =>
      CameraDataModel.fromMap(jsonDecode(source) as DataMap);
}
