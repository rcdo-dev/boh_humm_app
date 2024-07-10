import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';

class ConnectionSQlite implements IConnectionDb<Database> {
  @override
  Future<Database> connectionDatabase() async {
    var documentDirectoryPath = await getDatabasesPath();
    var path = join(documentDirectoryPath, 'app_motoboy.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE motoboy(
          mot_id INTEGER PRIMARY KEY AUTOINCREMENT,
          mot_name TEXT UNIQUE NOT NULL,
          mot_email TEXT,
          mot_image BLOB
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE slope (
          slo_id INTEGER PRIMARY KEY AUTOINCREMENT,
          slo_date DATE NOT NULL,
          slo_value REAL,
          slo_mot_id INTEGER UNIQUE NOT NULL,
          FOREIGN KEY (slo_mot_id) REFERENCES slope (mot_id)
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE delivery(
          del_id INTEGER PRIMARY KEY AUTOINCREMENT,
          del_order INTEGER,
          del_fee REAL
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE delivery_route(
          delr_id INTEGER PRIMARY KEY AUTOINCREMENT,
          delr_identifier INTEGER,
          delr_del_id INTEGER NOT NULL,
          delr_slo_id INTEGER NOT NULL,
          FOREIGN KEY (delr_del_id) REFERENCES delivery (del_id),
          FOREIGN KEY (delr_slo_id) REFERENCES slope (slo_id)
          );
          ''',
        );
      },
    );
  }
}
