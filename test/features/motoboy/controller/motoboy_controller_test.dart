import 'dart:typed_data';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motoboy_app_project/core/data_access/dao/i_dao.dart';
import 'package:motoboy_app_project/core/data_access/dao/impl/motoboy_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';
import 'package:motoboy_app_project/main.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MotoboyController {
  final IDao _dao;

  MotoboyController(
    this._dao,
  );

  Future<int?> saveMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.insert(data: motoboy);
  }
}

void main() {
  Modular.bindModule(AppModule());

  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  MotoboyModel motoboy = MotoboyModel(
    mot_name: 'moto4',
    mot_email: 'moto4@email.com',
    mot_image: Uint8List.fromList([4, 5, 6, 7]),
  );

  final motoboyDao = Modular.get<MotoboyDao>();
  MotoboyController controller = MotoboyController(motoboyDao);

  test('Must save a motoboy through the controller class', () async {
    int? lastId = await controller.saveMotoboy(motoboy: motoboy);
    expect(lastId, isNotNull);
  });
}
