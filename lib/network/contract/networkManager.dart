import 'package:notifications_admin/model/alert.dart';

abstract class NetworkManager {

  Future<List<Alert>> fetchAlerts();

  Future<bool> deleteAlert(String alertId);

  Future<bool> changeAlertStatus(String alertId, String alertStatus);

}