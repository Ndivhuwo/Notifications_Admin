import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:notifications_admin/model/dropDownSelect.dart';

class Constants{
  /*static const int RIDE_TYPE_ALL = 0;
  static const int RIDE_TYPE_CATCH = 1;
  static const int RIDE_TYPE_OFFER = 2;

  static String getRideTypeString(int rideType) {
    if(rideType == RIDE_TYPE_CATCH) {

    }
  }*/

  static const String baseUrl = "ec2-54-166-231-225.compute-1.amazonaws.com:8091";
  static const String placeholderImage = "http://ec2-54-166-231-225.compute-1.amazonaws.com:8091/api/v1/file/open/get/5tDeh2H6Omjk7y3xLFpPblKm4.png";

  static List<DropdownMenuItem<String>> getAlertStatuses() {
    List<DropdownMenuItem<String>> alertStatuses = [];
    alertStatuses.add(new DropdownMenuItem(
      child: new Text('Open'),
      value: "OPEN",
    ));
    alertStatuses.add(new DropdownMenuItem(
      child: new Text('Processing'),
      value: "PROCESSING",
    ));

    alertStatuses.add(new DropdownMenuItem(
      child: new Text('Closed'),
      value: "CLOSED",
    ));

    alertStatuses.add(new DropdownMenuItem(
      child: new Text('Archived'),
      value: "ARCHIVED",
    ));

    return alertStatuses;

  }

  static List<DropDownSelect> getAlertStatus() {
    List<DropDownSelect> list = [
      DropDownSelect(name: "Open", value: "Open"),
      DropDownSelect(name: "Processing", value: "Processing"),
      DropDownSelect(name: "Closed", value: "Closed"),
      DropDownSelect(name: "Archived", value: "Archived"),
    ];

    return list;
  }


}

