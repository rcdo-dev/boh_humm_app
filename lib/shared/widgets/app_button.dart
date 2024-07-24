import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final double? width;

  const AppButton({
    super.key,
    this.onPressed,
    this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
