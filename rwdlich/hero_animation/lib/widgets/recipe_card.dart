import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/recipe.dart';
import '../pages/recipe_detail.dart';
import 'fade_route.dart';
import 'icon_text.dart';
import 'ratings.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key key, @required this.recipe}) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      FadeRoute(page: RecipeDetail(recipe: recipe)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    Widget _content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RecipeImage(imagePath: recipe.imagePath),
        CardInfo(recipe: recipe),
      ],
    );

    if (isLandscape) {
      _content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RecipeImage(imagePath: recipe.imagePath),
          Container(
            width: screenWidth / 2,
            child: CardInfo(recipe: recipe),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        _navigateToDetail(context);
      },
      child: Container(
        margin: EdgeInsets.all(24.0),
        padding: isLandscape ? EdgeInsets.all(8) : null,
        child: Stack(
          children: <Widget>[
            Background(recipeName: recipe.name),
            _content,
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final String recipeName;
  const Background({
    Key key,
    this.recipeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "background-$recipeName",
      transitionOnUserGestures: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String imagePath;

  const RecipeImage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    return Container(
      height: screenHeight * 0.4,
      padding: isLandscape ? null : EdgeInsets.only(top: 16),
      child: Hero(
        tag: "recipe-$imagePath",
        transitionOnUserGestures: true,
        child: Image.asset(imagePath),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final Recipe recipe;

  const CardInfo({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;
    return Container(
      padding: isLandscape ? null : EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            recipe.name,
            style: Theme.of(context).textTheme.headline,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Ratings(value: 4),
          SizedBox(height: 16.0),
          Text(
            recipe.description,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontStyle: FontStyle.italic, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          SizedBox(height: 24.0),
          _buildExtra(context),
        ],
      ),
    );
  }

  Widget _buildExtra(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconText(
          icon: FontAwesomeIcons.solidClock,
          text: "10 minutes",
          iconColor: Theme.of(context).primaryColor,
        ),
        IconText(
          icon: FontAwesomeIcons.chartPie,
          text: "2 portions",
          iconColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
