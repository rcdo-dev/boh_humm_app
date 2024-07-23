import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:boh_humm/app_widget.dart';
import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/connection_db/impl/connection_sqlite.dart';
import 'package:boh_humm/features/motoboy/dao/motoboy_dao.dart';
import 'package:boh_humm/features/home/home_module.dart';

void main() {
  debugPrint(Modular.to.path);

  return runApp(
    ModularApp(module: AppModule(), child: AppWidget()),
  );
}

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<IConnectionDb>(ConnectionSQlite.new);
    i.addSingleton(MotoboyDao.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
  }
}
