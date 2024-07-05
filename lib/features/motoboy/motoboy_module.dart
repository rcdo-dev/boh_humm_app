import 'package:flutter_modular/flutter_modular.dart';
import 'package:motoboy_app_project/features/motoboy/page/motoboy_page.dart';

class MotoboyModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/motoboy', child: (context) => MotoboyPage());
  }
}
