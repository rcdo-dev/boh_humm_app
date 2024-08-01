import 'package:boh_humm/shared/widgets/app_circle_avatar.dart';
import 'package:flutter/material.dart';

class InitialPicture extends StatelessWidget {
  const InitialPicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircleAvatar(
      child: Icon(
        Icons.person,
        size: 115,
      ),
    );
  }
}
