import 'dart:async';
import 'package:driveme/dependency_injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/cars_list_bloc.dart';

class CarDetailsBloc {
  var carsListBloc = locator<CarsListBloc>();

  BehaviorSubject<Car> _itemController = BehaviorSubject<Car>();
  Stream<Car> get outItem => _itemController.stream;
  StreamSubscription _subscription;
  int _currentId;

  void getItem(int id) async {
    _itemController.sink.add(null);

    _currentId = id;
    if (_subscription != null) {
      _subscription.cancel();
    }

    _subscription = carsListBloc.outCars.listen((listOfItems) async {
      for (var item in listOfItems.items) {
        if (item.id == _currentId) {
          _itemController.sink.add(item);
          break;
        }
      }
    });
  }

  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    _itemController.close();
  }
}
