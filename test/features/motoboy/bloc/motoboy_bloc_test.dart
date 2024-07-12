import 'dart:async';

import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';

// -------------------------------------------------------

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

// -------------------------------------------------------

abstract class MotoboyState {}

class InitialMotoboy extends MotoboyState {}

class LoadingMotoboy extends MotoboyState {}

class LoadedMotoboy extends MotoboyState {
  final List<Map> motoboys;

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

// -------------------------------------------------------

class MotoboyBloc {
  final IDao dao;

  final _stateController = StreamController<MotoboyState>();
  final _eventController = StreamController<MotoboyEvent>();

  Stream<MotoboyState> get state => _stateController.stream;
  Sink<MotoboyEvent> get event => _eventController.sink;

  MotoboyBloc({
    required this.dao,
  }) {
    _eventController.stream.listen(_mapEventoToState);
  }

  void _mapEventoToState(MotoboyEvent event) async {
    if (event is RegisterMotoboy) {
      await dao.insert(data: event.motoboy);
      var listMotoboy = await dao.getAll() ?? [];
      _stateController.add(LoadedMotoboy(motoboys: listMotoboy));
    }
  }
}

// -------------------------------------------------------

void main() {
  test('description', () {});
}
