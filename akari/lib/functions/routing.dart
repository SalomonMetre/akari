import 'package:akari/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void goTo(BuildContext context,
    {bool push = false, required String destination}) {
  push ? context.pushNamed(destination) : context.goNamed(destination);
}

// void getHomePageBottomTab(BuildContext context, int index) {
  
// }
