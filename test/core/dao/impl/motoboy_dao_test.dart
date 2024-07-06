import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:motoboy_app_project/core/data_access/connection_db/impl/connection_sqlite.dart';
import 'package:motoboy_app_project/core/data_access/dao/i_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';
import 'package:motoboy_app_project/main.dart';

class MotoboyDao implements IDao<MotoboyModel> {
  final connection = Modular.get<ConnectionSQlite>();

   @override
  Future<int?> insert({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int lastId = await database.rawInsert(
        "INSERT INTO motoboy(mot_name, mot_email, mot_image) VALUES (?, ?, ?)",
        [data.mot_name, data.mot_email, data.mot_image],
      );
      database.close();
      return lastId;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }

    return null;
  }

  @override
  Future<MotoboyModel?> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
    var result = await database.rawQuery(
      "SELECT * FROM motoboy WHERE mot_id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      database.close();
      return MotoboyModel.fromMap(result.first);
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map>[];
    list = await database.rawQuery('SELECT * FROM motoboy');
    if (list.isNotEmpty) {
      database.close();
      return list;
    }
    database.close();
    return null;
  }

  @override
  Future<int> update({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();
    int id = await database.rawUpdate(
      "UPDATE motoboy SET mot_email = ?, mot_image = ? WHERE mot_name = ?",
      [data.mot_email, data.mot_image, data.mot_name],
    );
    database.close();
    return id;
  }

  @override
  Future<int> delete({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();
    int id = await database.rawDelete(
      "DELETE FROM motoboy WHERE mot_name = ?",
      [data.mot_name],
    );
    database.close();
    return id;
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
    mot_name: 'rcdo dev',
    mot_email: 'rcdo.dev@gmail.com',
    mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
  );

  MotoboyDao motoboyDao = MotoboyDao();

  test(
    'You must insert the data of a Motoboy object into the database.',
    () async {
      int? lastId = await motoboyDao.insert(data: motoboy);
      print(lastId);
      expect(lastId, isNotNull);
    },
  );

  test(
    'Must return a MotoboyModel object after performing a database query',
    () async {
      var motoboy = await motoboyDao.getById(id: 4);
      print(motoboy?.mot_name);
      expect(motoboy, isA<MotoboyModel>());
    },
  );

  test('It must return a list with the data of the motoboys', () async {
    var list = await motoboyDao.getAll();
    print(list);
    expect(list, isA<List<Map>>());
  });

  test('Must update the email and image of the motoboy', () async {
    int id = await motoboyDao.update(
      data: MotoboyModel(
        mot_name: 'Ricardo',
        mot_email: 'rcpompeo@gmail.com',
        mot_image: Uint8List.fromList(
          [4, 3, 2, 1],
        ),
      ),
    );
    print(id);
    expect(id, isNonZero);
  });

  test('You must exclude a motoboy', () async {
    int id = await motoboyDao.delete(
      data: MotoboyModel(
        mot_name: 'Ricardo Cardoso',
      ),
    );
    print(id);
    expect(id, isNonZero);
  });
}
