import 'package:flutter/material.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    this.width,
    this.height,
    this.color,
    super.key,
  });

  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10,
      width: width ?? 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
