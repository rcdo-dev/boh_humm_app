import 'package:sqflite/sqflite.dart';

import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/delivery_route/model/delivery_route_model.dart';

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
