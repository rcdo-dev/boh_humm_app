import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/core/data_access/dao/impl/motoboy_dao.dart';
import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';
import 'package:boh_humm/main.dart';

class MotoboyController {
  final IDao _dao;

  MotoboyController(
    this._dao,
  );

  Future<int?> saveMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.insert(data: motoboy);
  }

  Future<MotoboyModel?> getMotoboyById({required int id}) async {
    return await _dao.getById(id: id);
  }

  Future<List<Map>?> getAllMotoboys() async {
    return await _dao.getAll();
  }

  Future<int?> updateMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.update(data: motoboy);
  }

  Future<int?> deleteMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.delete(data: motoboy);
  }
}

void main() {
  Modular.bindModule(AppModule());

  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  MotoboyModel motoboy = MotoboyModel(
    mot_name: 'moto5',
    mot_email: 'moto5.moto@email.com',
    mot_image: Uint8List.fromList([4, 5, 6, 7]),
  );

  final motoboyDao = Modular.get<MotoboyDao>();
  MotoboyController controller = MotoboyController(motoboyDao);
  final int idMotoboy = 3;

  group('CRUD motoboy by Controller class', () {
    test('Must save a motoboy through the controller class', () async {
      var lastId = await controller.saveMotoboy(motoboy: motoboy);
      expect(lastId, isNotNull);
    });

    test('Must return a motoboy per id through the controller class', () async {
      var motoboyModel = await controller.getMotoboyById(id: idMotoboy);
      print(motoboyModel?.mot_name);
      expect(motoboyModel, isA<MotoboyModel>());
    });

    test('It must return a list of all motoboys through the controller class',
        () async {
      var list = await controller.getAllMotoboys();
      print(list?.first);
      expect(list, isNotEmpty);
    });

    test('Must update a motoboy through the controller class', () async {
      var id = await controller.updateMotoboy(motoboy: motoboy);
      print(id);
      expect(id, isNotNull);
    });

    test('Must exclude a motoboy through the controller class', () async {
      var id = await controller.deleteMotoboy(motoboy: motoboy);
      print(id);
      expect(id, isNotNull);
    });
  });

  // Finalizes the life cycle of the test suite.
  tearDownAll(() {
    print('Tests completed');
  });
}
