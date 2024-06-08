import 'package:akari/constants/debug_settings.dart';
import 'package:akari/firebase_options.dart';
import 'package:akari/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: DebugSettings.debugShowCheckedModeBanner,
    routerConfig: AppRouter.router,
  ));
}
