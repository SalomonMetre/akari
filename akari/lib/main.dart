import 'package:akari/constants.dart/debug_options.dart';
import 'package:akari/constants.dart/page_names.dart';
import 'package:akari/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
    initialRoute: PageNames.home,
    routes: appRoutes,
  ));
}