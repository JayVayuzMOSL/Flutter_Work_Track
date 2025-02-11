import 'package:flutter/material.dart';
import 'package:flutter_work_track/app.dart';
import 'package:flutter_work_track/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await setupLocator();

  runApp(const WorkTrackApp());
}
