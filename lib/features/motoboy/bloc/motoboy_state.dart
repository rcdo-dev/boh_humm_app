import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';

abstract class MotoboyState {}

class InitialMotoboy extends MotoboyState {}

class LoadingMotoboy extends MotoboyState {}

class LoadedMotoboy extends MotoboyState {
  final List<Map>? motoboys;

  LoadedMotoboy({
    this.motoboys,
  });
}

class LoadedMotoboyById extends MotoboyState {
  final MotoboyModel? motoboy;

  LoadedMotoboyById({
    this.motoboy,
  });
}

class ErrorMotoboy extends MotoboyState {
  final String errorMessage;

  ErrorMotoboy({
    required this.errorMessage,
  });
}
