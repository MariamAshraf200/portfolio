import 'package:flutter/material.dart';
import 'package:protofolio/app/protofolio_app.dart';
import 'package:protofolio/core/di/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const ProtofolioApp());
}
