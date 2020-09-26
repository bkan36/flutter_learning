import 'package:driveme/database/cars_database.dart';
import 'package:driveme/details/car_details_bloc.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<CarsDataProvider>(() => CarsDatabase());
  locator.registerSingleton(CarsListBloc());
  locator.registerSingleton(CarDetailsBloc());
}
