import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/app.dart';
import 'package:flutter_bloc_auth/src/core/locator.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}
