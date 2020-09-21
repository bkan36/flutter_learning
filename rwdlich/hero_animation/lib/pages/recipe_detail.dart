import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/navigation_item.dart';
import '../models/recipe.dart';
import '../widgets/icon_text.dart';
import '../widgets/ratings.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({Key key, @required this.recipe}) : super(key: key);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _show;
  Animation<double> _navAnimation;
  Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _show = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _navAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _show,
      curve: Interval(0.4, 1, curve: Curves.fastOutSlowIn),
    ));

    _contentAnimation = Tween<Offset>(
      begin: Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _show,
      curve: Interval(0, 0.6, curve: Curves.easeIn),
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 700), () {
        _show.forward();
      });
    });
  }

  @override
  void dispose() {
    _show.dispose();
    super.dispose();
  }

  void _navigateBack() {
    _show.reverse();
    Future.delayed(Duration(milliseconds: 360), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 28),
            onPressed: () {
              _navigateBack();
            },
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
        bottomNavigationBar: SizeTransition(
          sizeFactor: _navAnimation,
          axisAlignment: -1,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: navItems
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      title: Text(item.title),
                    ))
                .toList(),
            currentIndex: 0,
            backgroundColor: Color(0xFFf0efed),
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Container(
                        // A fixed-height child.
                        height: 200,
                        child: Header(recipe: widget.recipe),
                      ),
                      Expanded(
                        // A flexible child that will grow to fit the viewport but
                        // still be at least as big as necessary to fit its contents.
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            HeroBackground(recipe: widget.recipe),
                            Column(
                              children: <Widget>[
                                Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -30.0, 0.0),
                                  child: HeroRecipeImage(
                                    imagePath: widget.recipe.imagePath,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _show,
                                  builder: (context, child) {
                                    return SlideTransition(
                                      position: _contentAnimation,
                                      child: Opacity(
                                        opacity: _show.value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      IngredientList(
                                        ingredients: widget.recipe.ingredients,
                                      ),
                                      // Other contents can be added here
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
      child: Column(
        children: <Widget>[
          Text(
            recipe.name,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Ratings(
            value: 4,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconText(
                  icon: FontAwesomeIcons.solidClock,
                  text: "10 minutes",
                  iconColor: Colors.white,
                  fontColor: Colors.white,
                ),
                IconText(
                  icon: FontAwesomeIcons.chartPie,
                  text: "2 portions",
                  iconColor: Colors.white,
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroRecipeImage extends StatelessWidget {
  const HeroRecipeImage({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double recipeImageHeight = screenHeight * 0.25;
    return Hero(
      tag: "recipe-$imagePath",
      transitionOnUserGestures: true,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final Hero toHero = toHeroContext.widget;
        return RotationTransition(
          turns: animation,
          child: toHero.child,
        );
      },
      child: Image.asset(
        imagePath,
        height: recipeImageHeight,
      ),
    );
  }
}

class HeroBackground extends StatelessWidget {
  const HeroBackground({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "background-${recipe.name}",
      transitionOnUserGestures: true,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        Animation<BorderRadius> _borderAnimation;

        _borderAnimation = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(0.0),
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
        );
        return AnimatedBuilder(
          animation: _borderAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: _borderAnimation.value,
                color: Colors.white,
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  const IngredientList({
    Key key,
    @required this.ingredients,
  }) : super(key: key);

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: (screenWidth / 2) - 1,
            child: Container(
              transform: Matrix4.translationValues(0, -30, 0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black26, width: 2),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: ingredients.map((ingredient) {
                return IngredientRow(
                  ingredient: ingredient,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientRow extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientRow({Key key, this.ingredient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              ingredient.quantity,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          ClipOval(
            child: Image.asset(
              ingredient.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 32),
              child: Text(
                ingredient.name,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
