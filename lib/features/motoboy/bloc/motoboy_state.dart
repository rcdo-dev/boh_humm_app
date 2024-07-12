import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';

abstract class MotoboyState {}

class InitialMotoboy extends MotoboyState {}

class LoadingMotoboy extends MotoboyState {}

class LoadedMotoboy extends MotoboyState {
  final List<MotoboyModel> motoboys;

  LoadedMotoboy({
    required this.motoboys,
  });
}

class ErrorMotoboy extends MotoboyState {
  final String errorMessage;

  ErrorMotoboy({
    required this.errorMessage,
  });
}
