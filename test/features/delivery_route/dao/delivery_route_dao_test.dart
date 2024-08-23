import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/delivery_route/model/delivery_route_model.dart';
import 'package:boh_humm/main.dart';

class DeliveryRouteDao implements IDao<DeliveryRouteModel> {
  final IConnectionDb connectionDb;

  DeliveryRouteDao({
    required this.connectionDb,
  });

  @override
  Future<int?> insert({DeliveryRouteModel? data}) async {
    Database database = await connectionDb.connectionDatabase();

    if (data != null) {
      try {
        int lastId = await database.rawInsert(
          "INSERT INTO delivery_route(delr_identifier, delr_slo_id) values (?, ?)",
          [data.delr_identifier, data.delr_slo_id],
        );
        return lastId;
      } catch (e, s) {
        print('Exception: $e\n\nStackTrace: $s');
      } finally {
        database.close();
      }
    }
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connectionDb.connectionDatabase();
    var list = <Map<String, Object?>>[];

    try {
      list = await database.rawQuery("SELECT * FROM delivery_route");
      if (list.isNotEmpty) {
        return list;
      }
      return null;
    } catch (e, s) {
      print('Exception: $e\n\nStackTrace: $s');
    } finally {
      database.close();
    }
    return null;
  }

  @override
  Future<DeliveryRouteModel?> getById({int? id}) async {
    Database database = await connectionDb.connectionDatabase();

    if (id != null) {
      try {
        var result = await database.rawQuery(
          "SELECT delr_id, delr_identifier, delr_slo_id FROM delivery_route WHERE delr_id = ?",
          [id],
        );
        if (result.isNotEmpty) {
          return DeliveryRouteModel.fromMap(result.first);
        }
        return null;
      } catch (e, s) {
        print('Exception: $e\n\nStackTrace: $s');
      } finally {
        database.close();
      }
    }
    return null;
  }

  @override
  Future<int?> update({required DeliveryRouteModel data}) {
    /// If there is logic for updating
    /// the delivery route, implement it here.
    throw UnimplementedError();
  }

  @override
  Future<int?> delete({required DeliveryRouteModel data}) async {
    Database database = await connectionDb.connectionDatabase();

    try {
      int amountChanges = await database.rawDelete(
        "DELETE FROM delivery_route WHERE delr_id = ?",
        [data.delr_id],
      );
      return amountChanges;
    } catch (e, s) {
      print('Exception: $e\n\nStackTrace: $s');
    } finally {
      database.close();
    }
    return null;
  }
}

void main() {
  Modular.bindModule(AppModule());

  late DeliveryRouteModel deliveryRouteModel;
  late IConnectionDb connection;
  late DeliveryRouteDao deliveryRouteDao;

  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    connection = Modular.get<IConnectionDb>();
    deliveryRouteDao = DeliveryRouteDao(connectionDb: connection);

    deliveryRouteModel = DeliveryRouteModel(
      delr_identifier: 5,
      delr_slo_id: 1,
    );
  });

  tearDownAll(() {
    print('All tests were carried out.');
  });

  group('Persistence delivery_route by DeliveryRoute class |', () {
    test('Must insert a DeliveryRoute object into the database.', () async {
      int? id = await deliveryRouteDao.insert(data: deliveryRouteModel);
      print(id);
      expect(id, isNotNull);
    });

    test('Must return a list of delivery data.', () async {
      var list = await deliveryRouteDao.getAll();
      print(list);
      expect(list, isNotEmpty);
    });

    test('Must return a delivery route object using an id.', () async {
      var deliveryRouteModel = await deliveryRouteDao.getById(id: 2);
      if (deliveryRouteModel != null) {
        print(
          'Rota id:\t\t${deliveryRouteModel.delr_id}\nIdentificador rota:\t${deliveryRouteModel.delr_identifier}\nEncosta id:\t\t${deliveryRouteModel.delr_slo_id}',
        );
      }
      expect(deliveryRouteModel, isA<DeliveryRouteModel>());
    });

    test('Must delete a DeliveryRoute object.', () async {
      DeliveryRouteModel deliveryRouteDelete = DeliveryRouteModel(
        delr_id: 2,
      );

      int? amount = await deliveryRouteDao.delete(data: deliveryRouteDelete);
      print('Registros deletado: $amount');
      expect(amount, greaterThan(0));
    });
  });
}
