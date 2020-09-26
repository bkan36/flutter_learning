import 'package:driveme/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:driveme/details/car_details_bloc.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/constants.dart';

class CarDetailsPage extends StatefulWidget {
  CarDetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  var carsDetailsBloc = locator<CarDetailsBloc>();
  var carsListBloc = locator<CarsListBloc>();

  @override
  void initState() {
    super.initState();
    carsDetailsBloc.getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Car>(
          stream: carsDetailsBloc.outItem,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<Car> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Text(snapshot.data.title);
            }
          },
        ),
      ),
      body: StreamBuilder<Car>(
        key: Key(CAR_DETAILS_KEY),
        stream: carsDetailsBloc.outItem,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Car> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildDetailsView(snapshot.data);
          }
        },
      ),
    );
  }

  Text _buildFeaturesView(List<dynamic> features) {
    var allFeatures = StringBuffer();
    features.forEach((feature) {
      allFeatures.write('\n' + feature + '\n');
    });
    return Text(allFeatures.toString());
  }

  Widget _buildDetailsView(Car item) {
    Widget button = item.selected
        ? RaisedButton(
            child: Text(REMOVE_BUTTON),
            onPressed: () => carsListBloc.deselectItem(widget.id))
        : RaisedButton(
            child: Text(SELECT_BUTTON),
            onPressed: () => carsListBloc.selectItem(widget.id),
          );
    return Container(
      padding: EdgeInsets.all(24.0),
      child: ListView(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: (item.url == null || item.url.isEmpty)
                  ? Image.asset(PLACEHOLDER_IMAGE_FILEPATH,
                      height: 150, fit: BoxFit.cover)
                  : Image.network(item.url, height: 150, fit: BoxFit.cover)),
          SizedBox(
            height: 11.0,
          ),
          Text(
            item.selected ? SELECTED_TITLE : NOT_SELECTED_TITLE,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 22.0,
          ),
          Text(item.description),
          SizedBox(
            height: 33.0,
          ),
          Text(
            FEATURES_TITLE,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildFeaturesView(item.features),
          SizedBox(
            height: 8.0,
          ),
          button
        ],
      ),
    );
  }
}
