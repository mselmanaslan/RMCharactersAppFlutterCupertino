import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoritedCharacters/FavoritedCharactersView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/RMCharacters/RMCharactersView.dart';

class TabBarView extends StatefulWidget {
  const TabBarView({super.key});

  @override
  State<TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        border: null,
        backgroundColor: CupertinoColors.white.withOpacity(0.8),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: 'Characters',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        Widget tab;
        switch (index) {
          case 0:
            tab = FavoritedCharactersView();
            break;
          case 1:
            tab = RMCharactersView();
            break;
          default:
            tab = FavoritedCharactersView();
        }
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white.withOpacity(0.5),
          child: tab,
        );
      },
    );
  }
}
