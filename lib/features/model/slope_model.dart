import 'package:motoboy_app_project/features/model/delivery_route_model.dart';

class SlopeModel {
  final DateTime? date;
  final num? value;
  List<DeliveryRouteModel> deliveryRoutes;

  SlopeModel({
    this.date,
    this.value,
  }) : deliveryRoutes = [];

  void addDeliveryRoute({required DeliveryRouteModel deliveryRoute}) {
    deliveryRoutes.add(deliveryRoute);
  }
}
