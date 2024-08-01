import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;

  const AppCircleAvatar({
    super.key,
    this.backgroundImage,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundColor: Colors.yellow,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: backgroundImage,
        child: child,
      ),
    );
  }
}
