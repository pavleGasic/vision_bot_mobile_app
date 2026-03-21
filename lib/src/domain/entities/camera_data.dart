import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class CameraData extends Equatable {
  const CameraData({required this.data});

  final Uint8List data;

  @override
  List<Object?> get props => [data];
}
