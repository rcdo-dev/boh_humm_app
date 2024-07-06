import 'package:flutter_test/flutter_test.dart';
import 'package:motoboy_app_project/core/data_access/dao/i_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';

class MotoboyController {
  final IDao _dao;

  MotoboyController(
    this._dao,
  );

  Future<void> saveMotoboy({required MotoboyModel motoboy}) async {
    await _dao.insert(data: motoboy);
  }
}

void main() {
  test('description', () {});
}
