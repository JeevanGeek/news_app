import 'package:flutter/material.dart';
import 'package:news_app/utils/storage.dart';
import 'package:news_app/screens/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const NewsApp());
}
