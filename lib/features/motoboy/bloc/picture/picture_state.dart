import 'dart:io';

abstract class PictureState {}

class InitialPicture extends PictureState {}

class LoadedPicture extends PictureState {
  final File? picture;

  LoadedPicture({
    this.picture,
  });
}

class ErrorPicture extends PictureState {
  final String? erroMessage;

  ErrorPicture({
    this.erroMessage,
  });
}
