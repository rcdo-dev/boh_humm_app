import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/core/data_access/dao/impl/motoboy_dao.dart';
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
  final List<Map>? motoboys;

  LoadedMotoboy({
    this.motoboys,
  });
}

class ErrorMotoboy extends MotoboyState {
  final String errorMessage;

  ErrorMotoboy({
    required this.errorMessage,
  });
}

// -------------------------------------------------------

class MotoboyBloc extends Bloc<MotoboyEvent, MotoboyState> {
  final IDao dao;

  MotoboyBloc({
    required this.dao,
  }) : super(InitialMotoboy()) {
    on<MotoboyEvent>((event, emit) async {
      var listMotoboy = await dao.getAll() ?? [];
      emit(LoadedMotoboy(motoboys: listMotoboy));
    });
  }

  @override
  void onChange(Change<MotoboyState> change) {
    super.onChange(change);
    print('Estado: $change');
  }

  @override
  void onEvent(MotoboyEvent event) {
    super.onEvent(event);
    print('Evento: $event');
  }
}

// -------------------------------------------------------

class MotoboyDaoMock extends Mock implements MotoboyDao {}

// -------------------------------------------------------

void main() {
  final MotoboyDaoMock daoMock = MotoboyDaoMock();
  final MotoboyModel motoboy = MotoboyModel(
    mot_id: 1,
    mot_name: 'Ricardo c1',
    mot_email: 'rcdo.c1',
    mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
  );

  final List<Map> result = [
    motoboy.toMap(),
  ];

  when(() => daoMock.insert()).thenAnswer((_) async => 1);
  when(() => daoMock.getAll()).thenAnswer((_) async => result);

  blocTest<MotoboyBloc, MotoboyState>(
    'emits 1 when RegisterMotoboy is added',
    build: () => MotoboyBloc(dao: daoMock),
    act: (bloc) => bloc.add(RegisterMotoboy(motoboy: motoboy)),
    expect: () => [isA<LoadedMotoboy>()],
  );

  tearDown(() {
    print('Test finalized');
  });
}
