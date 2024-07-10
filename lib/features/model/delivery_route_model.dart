import 'package:boh_humm/features/model/delivery_model.dart';

class DeliveryRouteModel {
  final int? identifier;
  final List<DeliveryModel> deliveries;

  DeliveryRouteModel({
    this.identifier,
  }) : deliveries = [];

  void addDelivery({required DeliveryModel delivery}) {
    deliveries.add(delivery);
  }
}
