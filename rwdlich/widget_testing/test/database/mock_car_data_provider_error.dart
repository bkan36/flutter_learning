import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/models/car.dart';

const String MOCK_ERROR_MESSAGE = "This is an error message";

// TODO 2: Read the Mock Test Error Data
class MockCarDataProviderError implements CarsDataProvider {

  @override
  Future<CarsList> loadCars() {
    return Future.value(CarsList(null, MOCK_ERROR_MESSAGE));
  }

}

