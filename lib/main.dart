import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:motoboy_app_project/app_widget.dart';
import 'package:motoboy_app_project/core/data_access/connection_db/impl/connection_sqlite.dart';
import 'package:motoboy_app_project/features/home/home_module.dart';

void main() {
  debugPrint(Modular.to.path);

  return runApp(
    ModularApp(module: AppModule(), child: AppWidget()),
  );
}

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(ConnectionSQlite.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
  }
}
