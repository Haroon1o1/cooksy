import 'package:cooksy/Screens/HomeScreen/model/chefModel.dart';
import 'package:flutter/material.dart';

class ChefProvider with ChangeNotifier {
  final List<Chef> _chefs = [
    Chef(
      name: "Sarah's Kitchen",
      image: 'https://en.wikipedia.org/wiki/Biryani#/media/File:%22Hyderabadi_Dum_Biryani%22.jpg',
      distance: '1.2 km',
      rating: 4.7,
      reviews: 143,
    ),
    Chef(
      name: "Emy's Kitchen",
      image: 'https://en.wikipedia.org/wiki/Pizza#/media/File:Pizza-3007395.jpg',
      distance: '2.7 km',
      rating: 4.2,
      reviews: 187,
    ),
  ];

  List<Chef> get chefs => _chefs;

  void toggleFollow(int index) {
    _chefs[index].toggleFollow();
    notifyListeners();
  }

  List<Chef> filterChefs(String searchQuery) {
    if (searchQuery.isEmpty) return _chefs;

    return _chefs.where((chef) {
      return chef.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
}
