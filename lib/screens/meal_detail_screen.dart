import '../models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final void Function(String mealId) toggleFavorite;
  final bool Function(String mealId) isMealFavorite;

  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final meal = routeArgs['meal'] as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingrigients'),
            _buildContainer(ListView.builder(
              itemBuilder: (ctx, idx) => Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(meal.ingredients[idx]),
                ),
              ),
              itemCount: meal.ingredients.length,
            )),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(ListView.builder(
              itemBuilder: (ctx, idx) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('#${idx + 1}'),
                    ),
                    title: Text(meal.steps[idx]),
                  ),
                  Divider(),
                ],
              ),
              itemCount: meal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isMealFavorite(meal.id) ? Icons.favorite : Icons.favorite_outline),
        onPressed: () => toggleFavorite(meal.id),
      ),
    );
  }

  Container _buildContainer(ListView child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
