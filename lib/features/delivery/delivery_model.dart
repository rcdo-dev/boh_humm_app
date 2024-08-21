// ignore_for_file: non_constant_identifier_names

class DeliveryModel {
  final int? del_id;
  final int? del_order;
  final num? del_fee;
  final int? del_delr_id;

  DeliveryModel({
    this.del_id,
    this.del_order,
    this.del_fee,
    this.del_delr_id,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};
    map['del_id'] = del_id;
    map['del_order'] = del_order;
    map['del_fee'] = del_fee;
    map['del_delr_id'] = del_delr_id;
    return map;
  }

  factory DeliveryModel.fromMap(Map<String, Object?> map) {
    return DeliveryModel(
      del_id: int.tryParse(map['del_id'].toString()),
      del_order: int.tryParse(map['del_order'].toString()),
      del_fee: num.tryParse(map['del_fee'].toString()),
      del_delr_id: int.tryParse(map['del_delr_id'].toString()),
    );
  }
}
