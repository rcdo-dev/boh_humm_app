import 'dart:io';

import 'package:boh_humm/features/motoboy/blocs/picture/picture_state.dart';
import 'package:boh_humm/shared/widgets/app_circle_avatar.dart';
import 'package:flutter/material.dart';

class LoadedPicture extends StatelessWidget {
  final LoadedPictureState state;

  const LoadedPicture({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var image = state.picture as File;

    return AppCircleAvatar(
      backgroundImage: Image.file(
        image,
        fit: BoxFit.cover,
      ).image,
    );
  }
}
