import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App Motoboy',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      routerConfig: Modular.routerConfig,
    );
  }
}
