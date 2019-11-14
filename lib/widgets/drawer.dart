import 'package:flutter/material.dart';

class AppDrawer extends Drawer{

  @override
  Widget build(BuildContext context) {
    return defaultDrawer(context);
  }

  Drawer defaultDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: DrawerHeader(
              child: Image.asset(
                'assets/images/logo_512_round_.png',
                height: 134,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
              _onClickHome();
            },
          ),

          ListTile(
            title: Text("Services"),
            leading: Icon(Icons.playlist_add_check),
            onTap: () {
              Navigator.of(context).pop();
              //_onClickServices(context);
            },
          ),

          ListTile(
            title: Text("Pricing"),
            leading: Icon(Icons.monetization_on),
            onTap: () {
              Navigator.of(context).pop();
              //_onClickPricing(context);
            },
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: const Color(0xffE3E3E3),
              height: 0.2,
            ),
          ),

          ListTile(
            title: Text("Contact Us"),
            leading: Icon(Icons.contact_phone),
            onTap: () {
              Navigator.of(context).pop();
              //_onClickContactUs(context);
            },
          ),

          Expanded(

            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('© 2019 Top Code'),
              ),
            ),
          ),

        ],
      ),
    );
  }

  _onClickHome() {

  }

  /*_onClickServices(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Services()));
  }

  _onClickPricing(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Pricing()));
  }

  _onClickContactUs(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactUs()));
  }*/
}