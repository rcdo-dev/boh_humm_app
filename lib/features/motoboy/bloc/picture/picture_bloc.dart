import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boh_humm/features/motoboy/bloc/picture/picture_event.dart';
import 'package:boh_humm/features/motoboy/bloc/picture/picture_state.dart';
import 'package:image_picker/image_picker.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(InitialPicture()) {
    on<GetPictureGallery>((event, emit) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          emit(LoadedPicture(picture: File(pickedFile.path)));
        } else {
          emit(ErrorPicture(erroMessage: 'Nenhuma foto selecionada.'));
        }
      } catch (e, s) {
        emit(ErrorPicture(
          erroMessage: 'Erro ao selecionar foto: $e | StackTrace: $s',
        ));
      }
    });

    on<GetPictureCamera>((event, emit) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        if (pickedFile != null) {
          emit(LoadedPicture(picture: File(pickedFile.path)));
        } else {
          emit(ErrorPicture(erroMessage: 'Nenhuma foto selecionada.'));
        }
      } catch (e, s) {
        emit(ErrorPicture(
          erroMessage: 'Erro ao selecionar foto: $e | StackTrace: $s',
        ));
      }
    });
  }
}
