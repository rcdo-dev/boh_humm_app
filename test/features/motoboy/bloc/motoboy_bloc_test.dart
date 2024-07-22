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
  int? id;

  GetMotoboyById({
    this.id,
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

// -------------------------------------------------------

class MotoboyBloc extends Bloc<MotoboyEvent, MotoboyState> {
  final IDao dao;

  MotoboyBloc({
    required this.dao,
  }) : super(InitialMotoboy()) {
    on<RegisterMotoboy>((event, emit) async {
      emit(LoadingMotoboy());
      await dao.insert(data: event.motoboy);
      var listMotoboy = await dao.getAll() ?? [];
      emit(LoadedMotoboy(motoboys: listMotoboy));
    });

    on<GetAllMotoboys>((event, emit) async {
      emit(LoadingMotoboy());
      var listMotoboy = await dao.getAll() ?? [];
      emit(LoadedMotoboy(motoboys: listMotoboy));
    });

    on<GetMotoboyById>((event, emit) async {
      emit(LoadingMotoboy());
      var motoboy = await dao.getById(id: event.id);
      emit(LoadedMotoboyById(motoboy: motoboy));
    });
  }

  @override
  void onChange(Change<MotoboyState> change) {
    super.onChange(change);
    print('State: $change');
  }

  @override
  void onEvent(MotoboyEvent event) {
    super.onEvent(event);
    print('Event: $event');
  }
}

// -------------------------------------------------------

class MotoboyDaoMock extends Mock implements MotoboyDao {}

// -------------------------------------------------------

void main() {
  group('MotoboyBloc', () {
    late final MotoboyDaoMock daoMock;
    late final MotoboyModel motoboy;
    late final List<Map> result;

    setUpAll(() {
      daoMock = MotoboyDaoMock();
      motoboy = MotoboyModel(
        mot_id: 1,
        mot_name: 'Ricardo c1',
        mot_email: 'rcdo.c1',
        mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
      );
      result = [
        motoboy.toMap(),
      ];
      when(() => daoMock.insert(data: motoboy)).thenAnswer((_) async => 1);
      when(() => daoMock.getAll()).thenAnswer((_) async => result);
      when(() => daoMock.getById(id: motoboy.mot_id)).thenAnswer(
        (_) async => motoboy,
      );
    });

    blocTest<MotoboyBloc, MotoboyState>(
      'emits LoadedMotoboy state when RegisterMotoboy is added',
      build: () => MotoboyBloc(dao: daoMock),
      act: (bloc) => bloc.add(RegisterMotoboy(motoboy: motoboy)),
      expect: () => [
        isA<LoadingMotoboy>(),
        isA<LoadedMotoboy>().having(
          (state) => state.motoboys,
          'The motoboys list cannot be empty',
          isNotEmpty,
        )
      ],
    );

    blocTest<MotoboyBloc, MotoboyState>(
      'emits LoadedMotoboy state when GetAllMotoboys is added',
      build: () => MotoboyBloc(dao: daoMock),
      act: (bloc) => bloc.add(GetAllMotoboys()),
      expect: () => [
        isA<LoadingMotoboy>(),
        isA<LoadedMotoboy>().having(
          (state) => state.motoboys,
          'The motoboys list cannot be empty',
          isNotEmpty,
        ),
      ],
    );

    blocTest<MotoboyBloc, MotoboyState>(
      'emits LoadedMotoboyById state when GetMotoboyById is added',
      build: () => MotoboyBloc(dao: daoMock),
      act: (bloc) => bloc.add(GetMotoboyById(id: motoboy.mot_id)),
      expect: () => [
        isA<LoadingMotoboy>(),
        isA<LoadedMotoboyById>().having(
          (state) => state.motoboy,
          "The motoboy object can't be null",
          isNotNull,
        )
      ],
    );
    tearDownAll(() {
      print('Tests finalized');
    });
  });
}
