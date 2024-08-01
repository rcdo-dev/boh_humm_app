import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boh_humm/features/motoboy/blocs/picture/picture_event.dart';
import 'package:boh_humm/features/motoboy/blocs/picture/picture_state.dart';
import 'package:image_picker/image_picker.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(InitialPictureState()) {
    on<GetPictureGalleryEvent>((event, emit) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          emit(LoadedPictureState(picture: File(pickedFile.path)));
        } else {
          emit(ErrorPictureState(erroMessage: 'No photos selected.'));
        }
      } catch (e, s) {
        emit(ErrorPictureState(
          erroMessage: 'Error selecting photo: $e | StackTrace: $s',
        ));
      }
    });

    on<GetPictureCameraEvent>((event, emit) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        if (pickedFile != null) {
          emit(LoadedPictureState(picture: File(pickedFile.path)));
        } else {
          emit(ErrorPictureState(erroMessage: 'No photos selected.'));
        }
      } catch (e, s) {
        emit(ErrorPictureState(
          erroMessage: 'Error selecting photo: $e | StackTrace: $s',
        ));
      }
    });
  }
}
