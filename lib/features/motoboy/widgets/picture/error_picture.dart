import 'package:boh_humm/features/motoboy/blocs/picture/picture_state.dart';
import 'package:boh_humm/shared/widgets/app_circle_avatar.dart';
import 'package:flutter/material.dart';

class ErrorPicture extends StatelessWidget {
  final ErrorPictureState state;

  const ErrorPicture({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircleAvatar(
      child: Center(
        child: Text(
          state.erroMessage.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
