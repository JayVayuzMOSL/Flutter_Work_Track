import 'package:flutter/material.dart';
import 'package:flutter_work_track/service_locator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_work_track/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await setupLocator();

  runApp(const WorkTrackApp());
}
