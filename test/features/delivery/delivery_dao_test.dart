import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/delivery/model/delivery_model.dart';
import 'package:boh_humm/main.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DeliveryDao implements IDao<DeliveryModel> {
  final IConnectionDb connectionDb;

  DeliveryDao({
    required this.connectionDb,
  });

  @override
  Future<int?> insert({DeliveryModel? data}) async {
    Database database = await connectionDb.connectionDatabase();

    if (data != null) {
      try {
        int lastId = await database.rawInsert(
          "INSERT INTO delivery(del_order, del_fee, del_delr_id) values (?, ?, ?)",
          [data.del_order, data.del_fee, data.del_delr_id],
        );
        database.close();
        return lastId;
      } catch (e, s) {
        database.close();
        print('Exception: $e\n\nStackTrace: $s');
      }
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connectionDb.connectionDatabase();
    var list = <Map<String, Object?>>[];

    try {
      list = await database.rawQuery("SELECT * FROM delivery");
      if (list.isNotEmpty) {
        database.close();
        return list;
      }
      database.close();
    } catch (e, s) {
      database.close();
      print('Exception: $e\n\nStackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<DeliveryModel?> getById({int? id}) async {
    Database database = await connectionDb.connectionDatabase();

    if (id != null) {
      try {
        var result = await database.rawQuery(
          "SELECT * FROM delivery WHERE del_id =?",
          [id],
        );
        if (result.isNotEmpty) {
          database.close();
          return DeliveryModel.fromMap(result.first);
        }
        database.close();
        return null;
      } catch (e, s) {
        database.close();
        print('Exception: $e\n\nStackTrace: $s');
      }
    }
    database.close();
    return null;
  }

  @override
  Future<int?> update({required DeliveryModel data}) async {
    Database database = await connectionDb.connectionDatabase();

    try {
      int amountChanges = await database.rawUpdate(
        "UPDATE delivery SET del_order = ?, del_fee = ? WHERE del_id = ?",
        [data.del_order, data.del_fee, data.del_id],
      );
      database.close();
      return amountChanges;
    } catch (e, s) {
      database.close();
      print('Exception: $e\n\nStackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<int?> delete({required DeliveryModel data}) async {
    Database database = await connectionDb.connectionDatabase();

    try {
      int amountChanges = await database.rawDelete(
        "DELETE FROM delivery WHERE del_id = ?",
        [data.del_id],
      );
      database.close();
      return amountChanges;
    } catch (e, s) {
      database.close();
      print('Exception: $e\n\nStackTrace: $s');
    }
    database.close();
    return null;
  }
}

void main() {
  Modular.bindModule(AppModule());

  late DeliveryModel delivery;
  late IConnectionDb connection;
  late DeliveryDao deliveryDao;

  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    delivery = DeliveryModel(
      del_order: 346,
      del_fee: 11,
      del_delr_id: 2,
    );

    connection = Modular.get<IConnectionDb>();
    deliveryDao = DeliveryDao(connectionDb: connection);
  });

  tearDownAll(() {
    print('All tests were carried out.');
  });

  group('Persistence delivery by Delivery class |', () {
    test('Must insert a Delivery object into the database.', () async {
      int? lastId = await deliveryDao.insert(data: delivery);
      print(lastId);
      expect(lastId, isNotNull);
    });

    test('Must return a list of delivery data.', () async {
      var list = await deliveryDao.getAll();
      print(list);
      expect(list, isNotEmpty);
    });

    test('Must return a delivery object using an id.', () async {
      DeliveryModel? deliveryModel = await deliveryDao.getById(id: 4);
      if (deliveryModel != null) {
        print(
          'Entrega id:\t${deliveryModel.del_id}\nComanda:\t${deliveryModel.del_order}\nTaxa:\t\t${deliveryModel.del_fee}\nRota id:\t${deliveryModel.del_delr_id}',
        );
      }
      expect(deliveryModel, isA<DeliveryModel>());
    });

    test('Must update a Delivery object.', () async {
      DeliveryModel deliveryUpdate = DeliveryModel(
        del_id: 3,
        del_order: 10,
        del_fee: 6,
      );
      int? amount = await deliveryDao.update(data: deliveryUpdate);
      expect(amount, greaterThan(0));
    });

    test('Must delete a Delivery object.', () async {
      DeliveryModel deliveryDelete = DeliveryModel(
        del_id: 3,
      );
      int? amount = await deliveryDao.delete(data: deliveryDelete);
      expect(amount, greaterThan(0));
    });
  });
}
