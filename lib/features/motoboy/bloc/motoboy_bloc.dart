import 'package:bloc/bloc.dart';

import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/motoboy/bloc/motoboy_event.dart';
import 'package:boh_humm/features/motoboy/bloc/motoboy_state.dart';

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

    on<UpdateMotoboy>((event, emit) async {
      emit(LoadingMotoboy());
      await dao.update(data: event.motoboy);
      var motoboy = await dao.getById(id: event.motoboy.mot_id);
      emit(LoadedMotoboyById(motoboy: motoboy));
    });

    on<DeleteMotoboy>((event, emit) async {
      emit(LoadingMotoboy());
      await dao.delete(data: event.motoboy);
      emit(InitialMotoboy());
    });
  }
}
