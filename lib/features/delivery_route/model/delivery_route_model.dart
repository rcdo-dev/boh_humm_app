// ignore_for_file: non_constant_identifier_names

class DeliveryRouteModel {
  final int? delr_id;
  final int? delr_identifier;
  final int? delr_slo_id;

  DeliveryRouteModel({
    this.delr_id,
    this.delr_identifier,
    this.delr_slo_id,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};
    map['delr_id'] = delr_id;
    map['delr_identifier'] = delr_identifier;
    map['delr_slo_id'] = delr_slo_id;
    return map;
  }

  factory DeliveryRouteModel.fromMap(Map<String, Object?> map) {
    return DeliveryRouteModel(
      delr_id: int.tryParse(map['delr_id'].toString()),
      delr_identifier: int.tryParse(map['delr_identifier'].toString()),
      delr_slo_id: int.tryParse(map['delr_slo_id'].toString()),
    );
  }
}
