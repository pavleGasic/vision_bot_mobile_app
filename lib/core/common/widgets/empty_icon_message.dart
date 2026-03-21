import 'package:flutter/material.dart';

class EmptyIconMessage extends StatelessWidget {
  const EmptyIconMessage({
    required this.icon,
    required this.message,
    super.key,
  });

  final Icon icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          icon,
          Text(
            message,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
