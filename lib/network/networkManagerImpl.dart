import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:notifications_admin/constants.dart';
import 'package:notifications_admin/model/alert.dart';

import 'contract/networkManager.dart';

class NetworkManagerImpl implements NetworkManager{

  @override
  Future<bool> deleteAlert(String alertId) async{
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };

    Uri uri = Uri.http(Constants.baseUrl, "/api/v1/alert/open/delete/$alertId");
    final response = await http.post(uri, headers: requestHeaders);

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      print(response.body);
      return response.body.toLowerCase() == 'true';
    }else if(response.reasonPhrase != null) {
      throw Exception(response.reasonPhrase);
    } else {
      throw Exception('Failed to delete alerts Error: ${response.toString()}');
    }
  }

  @override
  Future<bool> changeAlertStatus(String alertId, String alertStatus) async{

    var queryParameters = {
      'alertStatus': alertStatus,
    };

    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };

    Uri uri = Uri.http(Constants.baseUrl, "/api/v1/alert/open/status/$alertId", queryParameters);
    final response = await http.post(uri, headers: requestHeaders);

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      print(response.body);
      return response.body.toLowerCase() == 'true';
    }else if(response.reasonPhrase != null) {
      throw Exception(response.reasonPhrase);
    } else {
      throw Exception('Failed to delete alerts Error: ${response.toString()}');
    }
  }

  @override
  Future<List<Alert>> fetchAlerts() async{
    var queryParameters = {
      'sortBy': "created",
      'sortDirection': "2",
    };

    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };

    Uri uri = Uri.http(Constants.baseUrl, "/api/v1/alert/open/list", queryParameters);
    final response = await http.post(uri, headers: requestHeaders);

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return (json.decode(response.body) as List).map((data) => Alert.fromJson(data)).toList();
    }else if(response.reasonPhrase != null) {
      throw Exception(response.reasonPhrase);
    } else {
      throw Exception('Failed to fetch alerts Error: ${response.toString()}');
    }
  }


}