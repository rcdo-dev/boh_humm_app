import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';
import 'package:boh_humm/main.dart';

class MotoboyDao implements IDao<MotoboyModel> {
  final IConnectionDb connection;

  MotoboyDao({
    required this.connection,
  });

  @override
  Future<int?> insert({MotoboyModel? data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int lastId = await database.rawInsert(
        "INSERT INTO motoboy(mot_name, mot_email, mot_image) VALUES (?, ?, ?)",
        [data?.mot_name, data?.mot_email, data?.mot_image],
      );
      database.close();
      return lastId;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<MotoboyModel?> getById({int? id}) async {
    Database database = await connection.connectionDatabase();

    try {
      var result = await database.rawQuery(
        "SELECT * FROM motoboy WHERE mot_id = ?",
        [id],
      );

      if (result.isNotEmpty) {
        database.close();
        return MotoboyModel.fromMap(result.first);
      }
      database.close();
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map>[];

    try {
      list = await database.rawQuery('SELECT * FROM motoboy');
      if (list.isNotEmpty) {
        database.close();
        return list;
      }
      database.close();
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<int?> update({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int id = await database.rawUpdate(
        "UPDATE motoboy SET mot_email = ?, mot_image = ? WHERE mot_name = ?",
        [data.mot_email, data.mot_image, data.mot_name],
      );
      database.close();
      return id;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<int?> delete({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int id = await database.rawDelete(
        "DELETE FROM motoboy WHERE mot_name = ?",
        [data.mot_name],
      );
      database.close();
      return id;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
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
    mot_name: 'Ricardo',
    mot_email: 'rcdo.dev@gmail.com',
    mot_image: Uint8List.fromList([0, 1, 2, 3, 4]),
  );

  final connection = Modular.get<IConnectionDb>();
  MotoboyDao motoboyDao = MotoboyDao(connection: connection);

  group('CRUD Motoboy by MotoboyDao class', () {
    test(
      'Must insert the data of a Motoboy object into the database.',
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
      var id = await motoboyDao.update(
        data: MotoboyModel(
          mot_name: 'Ricardo',
          mot_email: 'rcdo.dev@gmail.com',
          mot_image: Uint8List.fromList(
            [4, 3, 2, 1],
          ),
        ),
      );
      print(id);
      expect(id, isNonZero);
    });

    test('You must exclude a motoboy', () async {
      var id = await motoboyDao.delete(
        data: MotoboyModel(
          mot_name: 'rcdo1 dev',
        ),
      );
      print(id);
      expect(id, isNonZero);
    });
  });

  tearDownAll(() {
    print('Tests completed');
  });
}
