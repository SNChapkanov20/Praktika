import 'package:bubolechka2/data/categories.dart';
import 'package:bubolechka2/language_selector.dart';
import 'package:bubolechka2/models/bubo_category.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

void main() {
  runApp(const BuboApp());
}

class BuboApp extends StatelessWidget {
  const BuboApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BuboHomePage(),
    );
  }
}

///
/// HomePage of the Bubolechka Application
///
/// Displays the available categories and language selection on the main screen.
///
class BuboHomePage extends StatefulWidget {
  const BuboHomePage({super.key});

  @override
  State<BuboHomePage> createState() => _BuboHomePageState();
}


class _BuboHomePageState extends State<BuboHomePage> {
  String _language = 'bg';
  Map<String, String> _languageTitles = {
    'bg': 'Слънчева система',
    'en': 'Solar system',
    'de': 'Sonnensystem',
  };

  late BuboCategory _randomCategory;
  bool _showRandomImage = false;

  @override
  void initState() {
    super.initState();
    _randomCategory = getRandomCategory();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/planet.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100.0,
                  vertical: 5.0,
                ),
                color: const Color.fromARGB(255, 166, 166, 166)
                    .withOpacity(0.5),
                child: Text(
                  _languageTitles[_language] ?? 'Solar system',
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 150,
            left: 20,
            right: 20,
            child: BuboCategoryViewer(_language),
          ),
          Positioned(
            right: 30,
            bottom: 30,
            width: width > height ? 300 : 54,
            height: width < height ? 300 : 54,
            child: LanguageSelector(
              width > height,
              onLanguageChange: (newLanguage) {
                setState(() {
                  _language = newLanguage.toLowerCase();
                });
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            width: 200,
            child: Image.asset('assets/planet_logo.png'),
          ),
          if (_showRandomImage)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          if (_showRandomImage)
            Positioned(
              top: height / 2 - 250,
              left: width / 2 - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _randomCategory.translatedLabels[_language] ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    _randomCategory.image,
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _randomCategory = getRandomCategory();
                          _showRandomImage = true;
                        });
                      },
                      child: const Text('Generate Random Planet'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showRandomImage = false;
                      });
                    },
                    child: Text('Remove Random Planet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BuboCategory getRandomCategory() {
    final random = Random();
    return buboCategories[random.nextInt(buboCategories.length)];
  }
}





///
/// Category view for the main screen
///
/// Gets all available categories and places them into a list view
///
///
class BuboCategoryViewer extends StatelessWidget {
  final String language;
  BuboCategoryViewer(this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var widthPerCategory = 300;
    //print('Device size is: $width x $height');
    if (width > widthPerCategory) {
      var itemsPerRow = (width / widthPerCategory).floor();
      var rows = (buboCategories.length / itemsPerRow).ceil();
      //print('items per row: $itemsPerRow, rows: $rows');

      return GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
        crossAxisCount: itemsPerRow,
        children: buboCategories.map((buboCategory) {
          return BuboCategoryListItem(language, buboCategory);
        }).toList(),
      );
  
      ///
      /// Manual grid implementation
      ///
      // List<List<BuboCategory>> grid = [];

      // fill grid with empty rows
      // for (var i = 0; i < rows; i++) {
      //   grid.add([]);
      // }

      // // 0 1 2
      // // x x x
      // // x x B

      // add element to the respective row
      // for (var i = 0; i < buboCategories.length; i++) {
      //   grid[i % rows].add(buboCategories[i]);
      // }

      // var categoryRows = grid
      //     .map((rowWithCategories) => Row(
      //         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: rowWithCategories
      //             .map((category) => BuboCategoryListItem(language, category))
      //             .toList()))
      //     .toList();

      // return ListView(
      //   children: categoryRows,
      // );
    } else {
      return ListView(
        children: buboCategories.map((buboCategory) {
          return BuboCategoryListItem(language, buboCategory);
        }).toList(),
      );
    }

    // return ListView(
    //   children: buboCategories.map((buboCategory) {
    //     return BuboCategoryListItem(language, buboCategory);
    //   }).toList(),
    // );
  }
}

///
/// Widget for displaying a category on the main screen
///
/// TODO: Модифицирайте този клас така, че да показва не само името на
///       категорията, но и нейната картинка.
///       Картинките за всяка категория могат да се вземат по следният начин:
///       Image.asset(category.image)
///
///
class BuboCategoryListItem extends StatelessWidget {
  final String language;
  final BuboCategory category;

  const BuboCategoryListItem(this.language, this.category, {super.key});

   @override
    Widget build(BuildContext context) {
      return Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset(category.image, width: 249, fit: BoxFit.fill),
            Text(
          category.translatedLabels[language]!,
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white),
          ),
        ],
      ),
      Container(
      height: 10,
      )
    ]);
 }

  Widget _viewWithStack() {
    return Stack(
      children: [
        SizedBox(width: 250, height: 250, child: Image.asset(category.image)),
        Positioned(
            top: 190,
            left: 0,
            width: 250,
            child: Center(
                child: Text(
              category.translatedLabels[language] != null
                  ? category.translatedLabels[language]!
                  : 'Not available',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ))),
      ],
    );
  }

  Widget _viewWithContainer() {
    return Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(category.image))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
          child: Center(
            child: Text(
              category.translatedLabels[language] != null
                  ? category.translatedLabels[language]!
                  : 'Not available',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ));
  }
}
