import 'package:akari/constants/debug_settings.dart';
import 'package:akari/routes/routes.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: DebugSettings.debugShowCheckedModeBanner,
    routerConfig: AppRouter.router,
  ));
}
