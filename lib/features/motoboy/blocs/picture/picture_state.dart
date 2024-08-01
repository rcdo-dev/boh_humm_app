import 'dart:io';

abstract class PictureState {}

class InitialPictureState extends PictureState {}

class LoadedPictureState extends PictureState {
  final File? picture;

  LoadedPictureState({
    this.picture,
  });
}

class ErrorPictureState extends PictureState {
  final String? erroMessage;

  ErrorPictureState({
    this.erroMessage,
  });
}
