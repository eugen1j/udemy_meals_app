import 'package:flutter/material.dart';
import 'package:udemy_meals_app/models/meal.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet – start adding some',
        ),
      );
    }

    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (ctx, idx) {
        final meal = favoriteMeals[idx];
        return MealItem(meal);
      },
    );
  }
}
