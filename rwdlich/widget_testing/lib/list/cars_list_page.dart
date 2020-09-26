import 'package:driveme/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:driveme/details/car_details_page.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/constants.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var listBloc = locator<CarsListBloc>();

  @override
  void initState() {
    super.initState();
    listBloc.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LIST_PAGE_TITLE),
        ),
        body: StreamBuilder<CarsList>(
          stream: listBloc.outCars,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<CarsList> snapshot) {
            if (snapshot.hasError) {
              return _displayErrorMessage(snapshot.error.toString());
            } else if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data.errorMessage != null) {
              return _displayErrorMessage(snapshot.data.errorMessage);
            } else {
              return SingleChildScrollView(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  key: Key(CARS_LIST_KEY),
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.items.map((Car value) {
                    return _buildListRow(value);
                  }).toList(),
                ),
              );
            }
          },
        ));
  }

  Widget _displayErrorMessage(String errorMessage) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(ERROR_MESSAGE.replaceFirst(WILD_STRING, errorMessage)),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text(RETRY_BUTTON),
              onPressed: () {
                listBloc.loadItems();
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildListRow(Car car) {
    return Container(
        child: Card(
      color: car.selected ? Colors.blue.shade200 : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: (car.url == null || car.url.isEmpty)
                    ? Image.asset(PLACEHOLDER_IMAGE_FILEPATH,
                        height: 150, fit: BoxFit.cover)
                    : Image.network(car.url, height: 150, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                car.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            PRICE_PER_DAY_TEXT.replaceFirst(
                WILD_STRING, car.pricePerDay.toStringAsFixed(2)),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        onTap: () {
          _displayDetails(car);
        },
      ),
    ));
  }

  void _displayDetails(Car car) async {
    await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return CarDetailsPage(id: car.id);
      },
    ));
  }
}
