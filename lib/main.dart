import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes/index.dart';

void main() {
  runApp(MyApp());
  _initSettings();
}

void _initSettings() {
  //设置安卓上状态栏的沉浸式透明
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ncov',
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, //指定高亮主题
        //primaryColor: Colors.white
      ),
    );
  }
}
