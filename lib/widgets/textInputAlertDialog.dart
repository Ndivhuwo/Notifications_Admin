
import 'package:flutter/material.dart';
import 'package:notifications_admin/custom/callbacks.dart';

class MyTextInputAlertDialog extends StatelessWidget {
  final SingleParamCallback onClickCancel;
  final ThreeParamCallback onClickOk;
  final String cancelText;
  final String okText;
  final String title;
  final String param;
  final messageTitleController = TextEditingController();
  final messageBodyController = TextEditingController();

  MyTextInputAlertDialog(
      {this.onClickCancel,
      this.onClickOk,
      this.title,
      this.cancelText,
      this.okText,
      this.param});

  @override
  Widget build(BuildContext context) {
    return myDialog(context);
  }

  AlertDialog myDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        height: 500,
        child: Column(
          //shrinkWrap: true,
          children: <Widget>[
            _showMessageTitleInput(),
            _showMessageBodyInput(),
          ],
        ),
      ),
      actions: <Widget>[
        cancelText != null
            ? FlatButton(
                child: new Text(
                  cancelText,
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onClickCancel != null) {
                    onClickCancel(null);
                  }
                },
              )
            : Container(),
        okText != null
            ? FlatButton(
                child: new Text(
                  okText,
                  style: TextStyle(color: Colors.green, fontSize: 24),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onClickOk != null) {
                    if (messageTitleController.text.isNotEmpty && messageBodyController.text.isNotEmpty) {
                      onClickOk(param, messageTitleController.text,
                          messageBodyController.text);
                    } else {
                      onClickCancel("The Message title & body should not be empty!");
                    }
                  }
                },
              )
            : Container(),
      ],
    );
  }

  Widget _showMessageTitleInput() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(4),
      width: 432,
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        controller: messageTitleController,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Message Title',
            icon: Icon(
              Icons.title,
              color: Colors.amber,
            )),
        validator: (value) =>
            value.isEmpty ? 'Message title cant\'t be empty' : null,
      ),
    );
  }

  Widget _showMessageBodyInput() {
    return Container(
      alignment: Alignment.center,
        width: 432,
      padding: EdgeInsets.all(4),
      child: TextFormField(
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        controller: messageBodyController,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Message Body',
            icon: Icon(
              Icons.title,
              color: Colors.amber,
            )),
        validator: (value) =>
            value.isEmpty ? 'Message Body cant\'t be empty' : null,
      ),
    );
  }
}
