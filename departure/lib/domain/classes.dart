import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

List<dynamic> koreanList, bunsikList, japaneseList, westernList, chineseList;

class Menu {
  String name, hashTags, imageLink;

  Menu(this.name, this.hashTags, this.imageLink);
}

Future<List<Menu>> loadCSV() async {
  final koreanCSV = await rootBundle.loadString("assets/menus/korean.csv");
  koreanList = CsvToListConverter().convert(koreanCSV)[0];

  final bunsikCSV = await rootBundle.loadString("assets/menus/bunsik.csv");
  bunsikList = CsvToListConverter().convert(bunsikCSV)[0];

  final japaneseCSV = await rootBundle.loadString("assets/menus/japanese.csv");
  japaneseList = CsvToListConverter().convert(japaneseCSV)[0];

  final westernCSV = await rootBundle.loadString("assets/menus/western.csv");
  westernList = CsvToListConverter().convert(westernCSV)[0];

  final chineseCSV = await rootBundle.loadString("assets/menus/chinese.csv");
  chineseList = CsvToListConverter().convert(chineseCSV)[0];
}

List<Menu> getMenuList(menuNum, korean, bunsik, japanese, western, chinese) {
  List<Menu> totalList = [], menuList = [];

  if (korean) {
    for (int i = 0; i < koreanList.length - 1; i += 2) {
      totalList.add(Menu(koreanList[i], koreanList[i + 1],
          'assets/images/' + koreanList[i] + '.jpeg'));
    }
  }

  if (bunsik) {
    for (int i = 0; i < bunsikList.length - 1; i += 2) {
      totalList.add(Menu(bunsikList[i], bunsikList[i + 1],
          'assets/images/' + bunsikList[i] + '.jpeg'));
    }
  }

  if (japanese) {
    for (int i = 0; i < japaneseList.length - 1; i += 2) {
      totalList.add(Menu(japaneseList[i], japaneseList[i + 1],
          'assets/images/' + japaneseList[i] + '.jpeg'));
    }
  }

  if (western) {
    for (int i = 0; i < westernList.length - 1; i += 2) {
      totalList.add(Menu(westernList[i], westernList[i + 1],
          'assets/images/' + westernList[i] + '.jpeg'));
    }
  }

  if (chinese) {
    for (int i = 0; i < chineseList.length - 1; i += 2) {
      totalList.add(Menu(chineseList[i], chineseList[i + 1],
          'assets/images/' + chineseList[i] + '.jpeg'));
    }
  }

  if (menuNum < totalList.length) {
    menuList = totalList.sublist(0, menuNum);
    menuList.shuffle();
    return menuList;
  } else
    return null;
}
