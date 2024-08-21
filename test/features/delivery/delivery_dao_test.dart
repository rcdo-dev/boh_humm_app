import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/delivery/delivery_model.dart';
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
        int? lastId = await database.rawInsert(
          "INSERT INTO delivery(del_order, del_fee, del_delr_id) values (?, ?, ?)",
          [data.del_order, data.del_fee, data.del_delr_id],
        );
        database.close();
        return lastId;
      } catch (e, s) {
        print('Exception: $e, StackTrace: $s');
      }
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<DeliveryModel?> getById({int? id}) {
    throw UnimplementedError();
  }

  @override
  Future<int?> update({required DeliveryModel data}) {
    throw UnimplementedError();
  }

  @override
  Future<int?> delete({required DeliveryModel data}) {
    throw UnimplementedError();
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

  DeliveryModel delivery = DeliveryModel(
    del_order: 008,
    del_fee: 7,
    del_delr_id: 1,
  );

  final connection = Modular.get<IConnectionDb>();
  DeliveryDao deliveryDao = DeliveryDao(connectionDb: connection);

  test('Must insert a delivery object into the database', () async {
    int? lastId = await deliveryDao.insert(data: delivery);
    print(lastId);
    expect(lastId, isNotNull);
  });
}
