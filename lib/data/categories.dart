import '../models/bubo_category.dart';

///
/// This file provides the original category data
///

/// Original labels in german and bulgarian, english added as last value
const labels = [
  ["1", "Sonne", "Слънце", "Sun"],
  ["2", "Quecksilber", "Меркурий", "Mercury"],
  ["3", "Venus", "Венера", "Venus"],
  ["4", "Erde", "Земя", "Earth"],
  ["5", "Mars", "Марс", "Mars"],
  ["6", "Jupiter", "Юпитер", "Jupiter"],
  ["7", "Saturn", "Сатурн", "Saturn"],
  ["8", "Uranus", "Уран", "Uranus"],
  ["9", "Neptun", "Нептун", "Neptune"],
  ["10", "Mond", "Луна", "Moon"],
  
  
];

///
/// Labels transformed into BuboCategories
///
/// This list can be used in the application for rendering the categories
///
List<BuboCategory> buboCategories = labels.map((categoryLabels) {
  return BuboCategory(
      int.parse(categoryLabels[0]),
      'assets/categories/cat_${categoryLabels[1].toLowerCase().replaceAll(' ', '_')}@3x.png',
      {
        'us': categoryLabels[3],
        'de': categoryLabels[1],
        'bg': categoryLabels[2]
      });
}).toList();
