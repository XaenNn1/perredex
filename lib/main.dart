import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perredex/vista/DetailsScreen.dart';
import 'package:perredex/vista/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
