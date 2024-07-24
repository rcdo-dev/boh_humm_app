import 'package:flutter_modular/flutter_modular.dart';
import 'package:boh_humm/features/motoboy/page/motoboy_page.dart';

class MotoboyModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => MotoboyPage());
  }
}
