import 'package:flutter/material.dart';
import 'package:notifications_admin/constants.dart';
import 'package:notifications_admin/model/alert.dart';
import 'package:notifications_admin/model/dropDownSelect.dart';
import 'package:notifications_admin/network/contract/networkManager.dart';
import 'package:notifications_admin/widgets/MapUtil.dart';
import 'package:notifications_admin/widgets/alertDialog.dart';
import 'package:notifications_admin/widgets/textInputAlertDialog.dart';

class AdminHome extends StatefulWidget {
  final String userId;
  final VoidCallback onSignedOut;
  final NetworkManager networkManager;
  final String signedInUser;

  const AdminHome(
      {this.userId, this.onSignedOut, this.networkManager, this.signedInUser});

  @override
  State<StatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String _errorMessage = "";

  List<Alert> alertList;
  List<DropDownSelect> alertStatuses = Constants.getAlertStatus();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/notif_logo.png'),
        ),
        title: Text("Notifications Dashboard"),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              _refreshIndicatorKey.currentState.show();
            },
          ),
        ],
      ),
      //drawer: AppDrawer(),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshPage,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: alertList != null && alertList.length > 0
                ? ListView.builder(
                    itemCount: alertList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String alertStatus = alertList[index].alertStatus;
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: RaisedButton(
                          padding: EdgeInsets.all(8),
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1)),
                          color: Colors.white,
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          alertList[index].alertType,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        alignment: Alignment.bottomLeft,
                                        child: ListTile(
                                          title: Text(
                                            "${alertList[index].message}",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                            ),
                                          ),
                                          leading: Icon(Icons.message),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        alignment: Alignment.bottomLeft,
                                        child: ListTile(
                                          title: Text(
                                            alertList[index].address != null &&
                                                    alertList[index]
                                                        .address
                                                        .isNotEmpty
                                                ? alertList[index].address
                                                : "Unknown Address",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                            ),
                                          ),
                                          leading: Icon(Icons.location_on),
                                          onTap: () {
                                            if(alertList[index].address != null &&
                                                alertList[index]
                                                    .address
                                                    .isNotEmpty) {
                                              MapUtil.openMap(
                                                  alertList[index].latitude,
                                                  alertList[index].longitude);
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "${alertList[index].created}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Posted By ${alertList[index].userIdentification}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SizedBox(
                                      height: 120,
                                      child: Image.network(
                                          alertList[index].imageLink != null &&
                                                  alertList[index]
                                                      .imageLink
                                                      .isNotEmpty
                                              ? alertList[index].imageLink
                                              : Constants.placeholderImage),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        //color: Colors.green,
                                        child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                                alignedDropdown: false,
                                                child:
                                                    new DropdownButton<String>(
                                                  elevation: 2,
                                                  hint: new Text(
                                                    "Alert Status",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.blueGrey),
                                                  ),
                                                  value: alertStatus,
                                                  isExpanded: false,
                                                  iconSize: 10,
                                                  style: new TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontFamily: 'iransans',
                                                  ),
                                                  onChanged: (String value) {
                                                    alertStatus = value;
                                                    print("Selected user " +
                                                        alertStatus);
                                                    _changeAlertStatus(
                                                        alertList[index].id,
                                                        alertStatus);
                                                  },
                                                  items: alertStatuses
                                                      .map((DropDownSelect d) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: d.value,
                                                      child: new Text(
                                                        d.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ))),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: RaisedButton(
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1)),
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () => _deleteAlert(
                                              context,
                                              alertList[index].id,
                                              alertList[index].message,
                                              alertList[index].alertType,
                                              alertList[index]
                                                  .userIdentification),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : alertList != null
                    ? Text('There are no items to load, refresh!')
                    : Text(_errorMessage == null || _errorMessage.length < 1
                        ? 'Loading...'
                        : 'An Error Occured: $_errorMessage'),
          )),
    );
  }

  Future<void> _refreshPage() {
    return widget.networkManager.fetchAlerts().then((alerts) {
      setState(() {
        alertList = alerts;
      });
    }).catchError((error) {
      this.setState(() {
        //error.
        _errorMessage = error.toString();
        print('fetchAlerts Error: $_errorMessage');
      });
    });
  }

  _deleteAlert(BuildContext context, String alertId, String message,
      String alertType, String senderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return MyAlertDialog(
          onClickOk: _onClickDeleteOkListener,
          cancelText: "Cancel",
          okText: "Ok",
          title: "Delete Alert",
          message: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Posted By:',
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: senderId != null && senderId.isNotEmpty
                      ? senderId
                      : " Unknown",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                TextSpan(
                  text: '\nMessage:',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' $message',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                TextSpan(
                  text: '\nAlert Type:',
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' $alertType',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                TextSpan(
                  text: '\n\nAre you sure?',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                )
              ],
            ),
            //textAlign: TextAlign.end,
          ),
          param: alertId,
        );
      },
    );
  }

  _onClickDeleteOkListener(String alertId) {
    widget.networkManager.deleteAlert(alertId).then((success) {
      print('deleteAlert Response: $success');
      _refreshIndicatorKey.currentState.show();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MyAlertDialog(
            okText: "Ok",
            title: "Delete Alert",
            message: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Alert Deleted Successfully',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).catchError((error) {
      var errorMessage = error.toString();
      print('deleteAlert Error: $errorMessage');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MyAlertDialog(
            okText: "Ok",
            title: "Delete Alert",
            message: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Error Deleting Alert: $errorMessage',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  _changeAlertStatus(String alertId, String alertStatus) {
    widget.networkManager
        .changeAlertStatus(alertId, alertStatus)
        .then((success) {
      print('deleteAlert Response: $success');
      _refreshIndicatorKey.currentState.show();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MyAlertDialog(
            okText: "Ok",
            title: "Change Alert Status",
            message: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Alert Status changed Successfully',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).catchError((error) {
      var errorMessage = error.toString();
      print('deleteAlert Error: $errorMessage');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MyAlertDialog(
            okText: "Ok",
            title: "Change Alert Status",
            message: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Error Changing Alert Status: $errorMessage',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
