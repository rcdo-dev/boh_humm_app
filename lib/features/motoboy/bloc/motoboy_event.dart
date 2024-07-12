import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';

abstract class MotoboyEvent {}

class RegisterMotoboy extends MotoboyEvent {
  final MotoboyModel motoboy;

  RegisterMotoboy({
    required this.motoboy,
  });
}

class GetAllMotoboys extends MotoboyEvent {}

class GetMotoboyById extends MotoboyEvent {
  final int id;

  GetMotoboyById({
    required this.id,
  });
}

class UpdateMotoboy extends MotoboyEvent {
  final MotoboyModel motoboy;

  UpdateMotoboy({
    required this.motoboy,
  });
}

class DeleteMotoboy extends MotoboyEvent {
  final MotoboyModel motoboy;

  DeleteMotoboy({
    required this.motoboy,
  });
}
