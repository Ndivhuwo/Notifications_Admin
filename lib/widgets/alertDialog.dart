
import 'package:flutter/material.dart';
import 'package:notifications_admin/custom/callbacks.dart';

class MyAlertDialog extends StatelessWidget{
  final VoidCallback onClickCancel;
  final SingleParamCallback onClickOk;
  final String cancelText;
  final String okText;
  final RichText message;
  final String title;
  final String param;

  MyAlertDialog({this.onClickCancel, this.onClickOk, this.message, this.title, this.cancelText, this.okText, this.param});

  @override
  Widget build(BuildContext context) {
    return myDialog(context);
  }

  AlertDialog myDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message,
      actions: <Widget>[
        cancelText != null ? FlatButton(
          child: new Text(
            cancelText,
            style: TextStyle(color: Colors.red, fontSize: 24),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            if(onClickCancel != null) {
              onClickCancel();
            }
          },
        ) : Container(),

        okText != null ? FlatButton(
          child: new Text(
            okText,
            style: TextStyle(color: Colors.green, fontSize: 24),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            if (onClickOk != null) {
                onClickOk(param);
            }
          },
        ) : Container(),
      ],
    );
  }
}