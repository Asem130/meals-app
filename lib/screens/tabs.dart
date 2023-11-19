import 'package:flutter/material.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/main_drawer.dart';

import '../models/meal.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  void _setScreen(String identfier) async{
     Navigator.of(context).pop();
    if (identfier == 'filters') {
     final result = await Navigator.push<Map<Filter,bool>>(
        context,
        MaterialPageRoute(
          builder: (context) =>const  FilterScreen(),
        ),
      );
    }
  }

  final List<Meal> _favoriteMeals = [];
  void toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }

  int _currentIndex = 0;
  void changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoryScreen(
      onToggleFavorite: toggleFavorite,
    );
    var activeTitle = 'Category!';
    if (_currentIndex == 1) {
      activeScreen = MealsScreen(
        meal: _favoriteMeals,
        onToggleFavorite: toggleFavorite,
      );
      activeTitle = 'Your Favorite';
    }
    return Scaffold(
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
