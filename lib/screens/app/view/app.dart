import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/screens/loading/loading.dart';
import 'package:news_app/utils/strings.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Helvetica',
        primaryColor: kPrimaryColor,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: kSecondaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
          secondary: kPrimaryColor,
        ),
      ),
      home: const LoadingPage(),
    );
  }
}
