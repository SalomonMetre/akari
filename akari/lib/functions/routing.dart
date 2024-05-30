import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void goToNamed(BuildContext context,
    {bool push = false, required String destination}) {
  push ? context.pushNamed(destination) : context.goNamed(destination);
}

void goTo(BuildContext context,
    {bool push = false, required String destination}) {
  push ? context.push(destination) : context.go(destination);
}
