import 'package:flutter/material.dart';
import 'package:meal/screens/meal_details.dart';
import 'package:meal/widgets/meal_list_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meal,
      required this.onToggleFavorite});
  final String? title;
  final List<Meal> meal;
  final void Function(Meal meal) onToggleFavorite;
  void selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetails(meal: meal,onToggleFavorite: onToggleFavorite,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh no ..... nothing here ',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 24,
          ),
          Text('Try selecting a different categoey ',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
        ],
      ),
    );
    if (meal.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) =>
            MealItem(meal: meal[index], onSelectedMeal: selectedMeal),
        itemCount: meal.length,
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
        ),
      ),
      body: content,
    );
  }
}
