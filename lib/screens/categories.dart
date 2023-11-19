import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data%20.dart';
import 'package:meal/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';
import 'meals.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key,required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;
  void _navigation(BuildContext ctx, Category category) {
    final filterdMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: category.title, meal: filterdMeals,onToggleFavorite: onToggleFavorite,)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryItem(
              category: category,
              navigation: () {
                _navigation(context, category);
              })
      ],
    );
  }
}
