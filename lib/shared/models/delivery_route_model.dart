import 'package:boh_humm/shared/models/delivery_model.dart';

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
