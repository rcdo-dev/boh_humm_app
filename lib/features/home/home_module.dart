import 'package:flutter_modular/flutter_modular.dart';
import 'package:motoboy_app_project/features/home/page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => HomePage());
  }
}
