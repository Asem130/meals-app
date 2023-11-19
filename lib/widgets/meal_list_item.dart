import 'package:flutter/material.dart';
import 'package:meal/widgets/item_row.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectedMeal});
  final Meal meal;
  String get complexityText {
      return meal.complexity.name[0].toUpperCase() +
          meal.complexity.name.substring(1);
    }

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  final void Function(BuildContext context, Meal meal) onSelectedMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSelectedMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                meal.imageUrl,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemRow(
                          icon: Icons.schedule,
                          lable: meal.duration.toString(),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MealItemRow(icon: Icons.work, lable: complexityText),
                        const SizedBox(
                          width: 15,
                        ),
                        MealItemRow(
                          icon: Icons.attach_money,
                          lable: affordability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
