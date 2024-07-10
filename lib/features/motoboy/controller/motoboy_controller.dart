import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/motoboy/model/motoboy_model.dart';

class MotoboyController {
  final IDao _dao;

  MotoboyController(
    this._dao,
  );

  Future<int?> saveMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.insert(data: motoboy);
  }

  Future<MotoboyModel?> getMotoboyById({required int id}) async {
    return await _dao.getById(id: id);
  }

  Future<List<Map>?> getAllMotoboys() async {
    return await _dao.getAll();
  }

  Future<int?> updateMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.update(data: motoboy);
  }

  Future<int?> deleteMotoboy({required MotoboyModel motoboy}) async {
    return await _dao.delete(data: motoboy);
  }
}
