import 'package:driveme/constants.dart';
import 'package:driveme/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:driveme/details/car_details_bloc.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/list/cars_list_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var carsListBloc = locator<CarsListBloc>();
  var carDetailsBloc = locator<CarDetailsBloc>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }

  @override
  void dispose() {
    carsListBloc.dispose();
    carDetailsBloc.dispose();
    super.dispose();
  }
}
