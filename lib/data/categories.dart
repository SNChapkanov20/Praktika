import '../models/bubo_category.dart';

///
/// This file provides the original category data
///

/// Original labels in german and bulgarian, english added as last value
const labels = [
  ["1", "Sonne", "Слънце", "Sun", "ES"],
  ["2", "Quecksilber", "Меркурий", "Mercury"],
  ["3", "Venus", "Венера", "Venus"],
  ["4", "Sachen", "Земя", "clothes"],
  ["5", "Spielzeug", "Марс", "toys"],
  ["6", "Tiere", "Юпитер", "animals"],
  ["7", "Wilde Tiere", "Сатурн", "wild animals"],
  ["8", "Zahlen", "Уран", "digits"],
  ["9", "Wetter", "Нептун", "weather"],
  ["10", "Zu Hause", "Луна", "at home"],
  
  
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
