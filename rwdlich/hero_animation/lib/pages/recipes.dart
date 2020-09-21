import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 28,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 24, 8),
            child: Icon(
              FontAwesomeIcons.heart,
              size: 28,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: PageView(
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            children:
                recipes.map((recipe) => RecipeCard(recipe: recipe)).toList(),
          ),
        ),
      ),
    );
  }
}
