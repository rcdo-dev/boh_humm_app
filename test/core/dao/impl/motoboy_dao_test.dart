import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:motoboy_app_project/core/connection_db/connection_sqlite.dart';
import 'package:motoboy_app_project/core/dao/i_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';
import 'package:motoboy_app_project/main.dart';

class MotoboyDao implements IDao<MotoboyModel> {
  @override
  Future<int> insert({required MotoboyModel data}) async {
    final connection = Modular.get<ConnectionSQlite>();
    Database database = await connection.connectionDatabase();

    int lastId = await database.insert(
      'motoboy',
      data.toMap(),
    );

    database.close();

    return lastId;
  }

  @override
  Future<MotoboyModel?> getById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required MotoboyModel data}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required int id}) {
    throw UnimplementedError();
  }
}

void main() {
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
    Modular.bindModule(AppModule());
  });

  MotoboyModel motoboy = MotoboyModel(
    mot_name: 'Ricardo Cardoso Pompêo',
    mot_email: 'rcdo.dev@gmail.com',
    mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
  );

  MotoboyDao motoboyDao = MotoboyDao();

  test(
    'You must insert the data of a Motoboy object into the database.',
    () async {
      int lastId = await motoboyDao.insert(data: motoboy);
      print(lastId);
      expect(lastId, isNonZero);
    },
  );
}
