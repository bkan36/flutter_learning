import 'package:meta/meta.dart';

class Recipe {
  final String name;
  final String imagePath;
  final String description;
  final List<Ingredient> ingredients;

  Recipe({
    this.name,
    this.imagePath,
    this.description,
    this.ingredients,
  });
}

class Ingredient {
  final String name;
  final String quantity;
  final String imagePath;

  Ingredient({
    @required this.name,
    @required this.quantity,
    @required this.imagePath,
  });
}

List<Recipe> recipes = [
  Recipe(
    name: "Tikka Chicken Pizza",
    description: "A touch of Italian Mozarella Cheese crust",
    imagePath: "assets/images/pizza.png",
    ingredients: [
      Ingredient(
        name: "Oatmeal",
        quantity: "1/2 c.",
        imagePath: "assets/images/oatmeal.jpg",
      ),
      Ingredient(
        name: "Walnuts",
        quantity: "1/2 tbsp.",
        imagePath: "assets/images/walnut.jpg",
      ),
      Ingredient(
        name: "Berries",
        quantity: "1/2 tbsp.",
        imagePath: "assets/images/berries.jpg",
      ),
    ],
  ),
  Recipe(
    name: "Burger Classico",
    description: "Vegatarian burger for an amazing delight",
    imagePath: "assets/images/hamburger.png",
    ingredients: [
      Ingredient(
        name: "Ham",
        quantity: "1/2 c.",
        imagePath: "assets/images/oatmeal.jpg",
      ),
      Ingredient(
        name: "Ketchup",
        quantity: "2 tbsp.",
        imagePath: "assets/images/walnut.jpg",
      ),
      Ingredient(
        name: "Mayonnaise",
        quantity: "3 tbsp.",
        imagePath: "assets/images/berries.jpg",
      ),
    ],
  )
];
