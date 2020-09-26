import 'dart:async';

import 'package:driveme/dependency_injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:driveme/models/car.dart';

class CarsListBloc {
  CarsDataProvider provider = locator<CarsDataProvider>();

  BehaviorSubject<CarsList> _itemsController = BehaviorSubject<CarsList>();
  Stream<CarsList> get outCars => _itemsController.stream;

  Future loadItems() async {
    CarsList items = await provider.loadCars();
    if (items.items != null) {
      items.items.sort(alphabetiseItemsByTitleIgnoreCases);
    }
    _itemsController.sink.add(items);
  }

  int alphabetiseItemsByTitleIgnoreCases(Car a, Car b) {
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  void selectItem(int id) {
    StreamSubscription subscription;
    subscription = outCars.listen((carsList) async {
      List<Car> newList = List<Car>();
      for (var car in carsList.items) {
        if (car.id == id) {
          newList.add(Car(
              id: car.id,
              title: car.title,
              description: car.description,
              url: car.url,
              pricePerDay: car.pricePerDay,
              selected: true,
              features: car.features));
        } else {
          newList.add(car);
        }
      }
      _itemsController.sink.add(CarsList(newList, null));
      subscription.cancel();
    });
  }

  void deselectItem(int id) {
    StreamSubscription subscription;
    subscription = outCars.listen((carsList) async {
      List<Car> newList = List<Car>();
      for (var car in carsList.items) {
        if (car.id == id) {
          newList.add(Car(
              id: car.id,
              title: car.title,
              description: car.description,
              url: car.url,
              pricePerDay: car.pricePerDay,
              selected: false,
              features: car.features));
        } else {
          newList.add(car);
        }
      }
      _itemsController.sink.add(CarsList(newList, null));
      subscription.cancel();
    });
  }

  void dispose() {
    _itemsController.close();
  }

  void injectDataProviderForTest(CarsDataProvider provider) {
    this.provider = provider;
  }
}

abstract class CarsDataProvider {
  Future<CarsList> loadCars();
}
