import 'package:flutter/material.dart';
import 'package:glina/app/app.dart';
import 'package:glina/dependency_injection/locator/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const GlinaApp());
}
