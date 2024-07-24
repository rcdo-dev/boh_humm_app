import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;

  const AppButton({
    super.key,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
