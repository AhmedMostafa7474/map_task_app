import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Drawerr(){
return Drawer(
child: new ListView(
children: <Widget> [
new DrawerHeader(child: new Text('Header'),),
new ListTile(
title: new Text('First Menu Item'),
onTap: () {},
),
new ListTile(
title: new Text('Second Menu Item'),
onTap: () {},
),
new Divider(),

],
));
}