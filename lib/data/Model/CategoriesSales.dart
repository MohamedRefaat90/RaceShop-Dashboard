import 'dart:math';

import 'package:flutter/material.dart';

class CategoriesSales {
  String name;
  double value;
  Color color;

  static List colorsPalettes = [
    const Color.fromARGB(255, 246, 114, 128),
    const Color.fromARGB(255, 192, 108, 132),
    const Color.fromARGB(255, 108, 91, 123),
    const Color.fromARGB(255, 53, 92, 125),
    const Color.fromARGB(255, 184, 59, 95)
  ];

  static List<CategoriesSales> categoriesSales = [];
  CategoriesSales(
      {required this.name, required this.value, required this.color});

  static getCategoriesSales(
      {required List categories, required int numofOrders}) {
    for (int i = 0; i < categories.length; i++) {
      if (i < colorsPalettes.length) {
        categoriesSales.add(CategoriesSales(
            name: categories[i].categoryName,
            value: (numofOrders * 5) / 100,
            color: colorsPalettes[i]));
      } else {
        categoriesSales.add(CategoriesSales(
            name: categories[i].categoryName,
            value: (numofOrders * 5) / 100,
            color: Color(Random().nextInt(0xffffffff)).withOpacity(1.0)));
      }
    }

    return categoriesSales;
  }
}
