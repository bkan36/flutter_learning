import 'package:driveme/constants.dart';

class Car {
  final int id;
  final String title;
  final String description;
  final String url;
  final double pricePerDay;
  bool selected;
  final List<dynamic> features;

  Car(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.pricePerDay,
      this.selected,
      this.features});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        id: json[CARS_ID_KEY],
        title: json[CARS_TITLE_KEY],
        description: json[CARS_DESCRIPTION_KEY],
        url: json[CARS_URL_KEY],
        pricePerDay: json[CARS_PRICEPERDAY_KEY],
        selected: false,
        features: json[CARS_FEATURES_KEY]);
  }
}

class CarsList {
  final List<Car> items;

  final String errorMessage;

  CarsList(this.items, this.errorMessage);
}
