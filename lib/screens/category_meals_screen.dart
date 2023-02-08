import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title = "";
  List<Meal> meals = [];
  bool _loadInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      title = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      meals = widget.availableMeals
          .where((m) => m.categories.contains(categoryId))
          .toList();
    }

    _loadInitData = true;
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() => meals.removeWhere((m) => m.id == mealId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, idx) {
          final meal = meals[idx];
          return MealItem(meal);
        },
      ),
    );
  }
}
