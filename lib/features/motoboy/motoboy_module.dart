import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/connection_db/impl/connection_sqlite.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/motoboy/bloc/motoboy_bloc.dart';
import 'package:boh_humm/features/motoboy/bloc/picture/picture_bloc.dart';
import 'package:boh_humm/features/motoboy/controller/motoboy_controller.dart';
import 'package:boh_humm/features/motoboy/dao/motoboy_dao.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:boh_humm/features/motoboy/page/motoboy_page.dart';

class MotoboyModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(MotoboyController.new);
    i.add<IConnectionDb>(ConnectionSQlite.new);
    i.addSingleton<IDao>(MotoboyDao.new);
    i.addSingleton(MotoboyBloc.new);

    i.add(PictureBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => MotoboyPage(
        controller: Modular.get<MotoboyController>(),
      ),
    );
  }
}
